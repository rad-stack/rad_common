module DuplicateFixable
  extend ActiveSupport::Concern

  included do
    include CreatedBy

    has_one :duplicate, as: :duplicatable, dependent: :destroy

    scope :duplicates_to_process, lambda {
      left_outer_joins(:duplicate)
        .where("duplicates.processed_at IS NULL OR (#{table_name}.updated_at >= duplicates.processed_at)")
        .order(:id)
    }

    scope :relevant_duplicates, lambda {
      joins(:duplicate).where('score IS NOT NULL AND score >= ?', score_lower_threshold)
    }

    scope :high_duplicates, lambda {
      joins(:duplicate).where('score IS NOT NULL AND score >= ? AND sort <= 500', score_upper_threshold)
    }
  end

  module ClassMethods
    def duplicates_enabled?
      new.duplicate_model_config.present?
    end

    def score_upper_threshold
      return 50 unless duplicates_enabled?

      new.duplicate_model_config[:score_upper_threshold].presence || 50
    end

    def score_lower_threshold
      new.duplicate_model_config[:score_lower_threshold].presence || 15
    end

    def configured_duplicate_items
      new.duplicate_model_config[:additional_items].presence || []
    end

    def use_birth_date?
      new.respond_to?(:birth_date)
    end

    def use_multiples?
      new.respond_to?(:multiples)
    end

    def use_email_2?
      new.respond_to?(:email_2)
    end

    def use_phone_number?
      new.respond_to?(:phone_number)
    end

    def use_phone_number_2?
      new.respond_to?(:phone_number_2)
    end

    def use_mobile_phone?
      new.respond_to?(:mobile_phone)
    end

    def use_address?
      new.respond_to?(:address_1) && !new.duplicates_bypass_address?
    end

    def use_first_last_name?
      new.respond_to?(:first_name)
    end

    def allow_merge_all?
      new.duplicate_model_config[:allow_merge_all].nil? ? false : new.duplicate_model_config[:allow_merge_all]
    end

    def additional_duplicate_items
      [{ name: :company_name, label: 'Company Name', type: :levenshtein, display_only: false, weight: 10 },
       { name: :email, label: 'Email', type: :string, display_only: false, weight: 20 },
       { name: :phone_number,
         label: 'Phone #',
         type: :string,
         display_only: false,
         weight: new.duplicate_other_weight },
       { name: 'mobile_phone',
         label: 'Mobile Phone',
         type: :string,
         display_only: false,
         weight: new.duplicate_other_weight },
       { name: 'fax_number',
         label: 'Fax #',
         type: :string,
         display_only: false,
         weight: 10 }] + configured_duplicate_items
    end

    def applicable_duplicate_items
      additional_duplicate_items.select { |item| new.respond_to?(item[:name]) }
    end
  end

  def process_duplicates
    contacts = []

    all_matches.each do |match|
      record = model_klass.find(match)
      score = duplicate_record_score(record)
      contacts.push(id: record.id, score: score)
    end

    contacts = contacts.sort_by { |item| item[:score] }.reverse.first(100)

    if contacts.any?
      raw_score = contacts.first[:score]
      create_or_update_metadata! duplicates_info: contacts.to_json, score: raw_score.positive? ? raw_score : nil
    else
      create_or_update_metadata! duplicates_info: nil, score: nil
    end
  end

  def reset_duplicates
    if duplicate.present?
      duplicate.destroy!
      reload
    end

    process_duplicates
  end

  def duplicates
    return [] if duplicate.blank? || duplicate.duplicates_info.blank?

    dupes = JSON.parse(duplicate.duplicates_info).select { |item| item['score'] >= self.class.score_lower_threshold }
    contacts = []

    dupes.each do |dupe|
      contact = model_klass.find_by(id: dupe['id'])
      next if contact.blank?

      contacts.push(record: contact, score: dupe['score'])
    end

    contacts.sort_by { |item| item[:score] }.reverse
  end

  def not_duplicate(other_record)
    set_not_duplicate self, other_record
    set_not_duplicate other_record, self
  end

  def create_or_update_metadata!(attributes)
    if duplicate.blank?
      Duplicate.create! attributes.merge(processed_at: Time.current, duplicatable: self)
    else
      duplicate.update! attributes.merge(processed_at: Time.current)
    end
  end

  def can_merge_duplicate?(_new_record)
    # override as needed in models
    true
  end

  def clean_up_duplicate(_new_record)
    # override as needed in models
  end

  def duplicate_first_name_weight
    duplicate_model_config[:first_name_weight].presence || 10
  end

  def duplicate_last_name_weight
    duplicate_model_config[:last_name_weight].presence || 10
  end

  def duplicate_other_weight
    duplicate_model_config[:other_weight].presence || 20
  end

  def duplicates_bypass_address?
    duplicate_model_config[:bypass_address].nil? ? false : duplicate_model_config[:bypass_address]
  end

  def duplicate_model_config
    RadCommon::AppInfo.new.duplicate_model_config(self.class.name)
  end

  def merge_duplicates(duplicate_keys, user)
    error = nil

    ActiveRecord::Base.transaction do
      duplicate_keys.each do |key|
        error = fix_duplicate(key, user)
        break if error
      end
    end

    if error.present?
      [:error, "Unable to process duplicates: #{error}"]
    else
      process_duplicates
      [:success, "The duplicates for #{self.class} '#{self}' were successfully resolved."]
    end
  end

  private

    def model_klass
      self.class.to_s.constantize
    end

    def table_name
      "#{self.class.to_s.underscore}s"
    end

    def all_matches
      (name_matches +
       similar_name_matches +
       birth_date_matches +
       additional_item_matches).uniq - no_matches(self)
    end

    def name_matches
      return [] unless model_klass.use_first_last_name?

      model_klass.where('id <> ? AND upper(first_name) = ? AND upper(last_name) = ?',
                        id,
                        first_name.upcase,
                        last_name.upcase).pluck(:id)
    end

    def similar_name_matches
      return [] unless model_klass.use_first_last_name?

      model_klass.where('id <> ? AND levenshtein(upper(first_name), ?) <= 1 AND levenshtein(upper(last_name), ?) <= 1',
                        id,
                        first_name.upcase,
                        last_name.upcase).pluck(:id)
    end

    def birth_date_matches
      return [] unless model_klass.use_birth_date? && model_klass.use_first_last_name?

      query_string = 'id <> ? AND birth_date = ? AND (levenshtein(upper(first_name), ?) <= 1 OR ' \
                     'levenshtein(upper(last_name), ?) <= 1)'

      model_klass.where(query_string,
                        id,
                        birth_date,
                        first_name.upcase,
                        last_name.upcase).pluck(:id)
    end

    def additional_item_matches
      items = []

      model_klass.applicable_duplicate_items.each do |item|
        item_value = send(item[:name])
        next if item[:display_only] || item_value.blank?

        query = case item[:type]
                when :association
                  "id <> ? AND #{item[:name]} IS NOT NULL AND #{item[:name]} = ?"
                when :levenshtein
                  "id <> ? AND levenshtein(upper(#{item[:name]}), ?) <= 1"
                else
                  "id <> ? AND #{item[:name]} IS NOT NULL AND #{item[:name]} <> '' AND #{item[:name]} = ?"
                end

        check_value = item[:type] == :levenshtein ? item_value.upcase : item_value
        items += model_klass.where(query, id, check_value).pluck(:id)
      end

      items
    end

    def duplicate_record_score(duplicate_record)
      score = 0

      all_duplicate_attributes.each do |attribute|
        score += duplicate_field_score(duplicate_record, attribute[:name], attribute[:weight])
      end

      score = 5 if family_member_same_home?(duplicate_record)

      ((score / all_duplicate_attributes.pluck(:weight).sum.to_f) * 100).to_i
    end

    def all_duplicate_attributes
      items = []

      if model_klass.use_first_last_name?
        items += [{ name: 'first_name', weight: duplicate_first_name_weight },
                  { name: 'last_name', weight: duplicate_last_name_weight }]
      end

      items.push(name: 'birth_date', weight: 30) if model_klass.use_birth_date?

      model_klass.applicable_duplicate_items.each do |item|
        next if item[:display_only]

        items.push(name: item[:name], weight: item[:weight]) if respond_to?(item[:name])
      end

      if model_klass.use_address?
        items += [{ name: 'city', weight: 10 },
                  { name: 'state', weight: 10 },
                  { name: 'zipcode', weight: 10 },
                  { name: 'address_1', weight: duplicate_other_weight },
                  { name: 'address_2', weight: duplicate_other_weight }]
      end

      items
    end

    def family_member_same_home?(duplicate_record)
      return false unless model_klass.use_address? && name_and_address_present?(self)
      return false if duplicate_record.first_name.blank?

      birth_date_compare(duplicate_record, 1) && birth_date_compare(self, 2) &&
        first_name != duplicate_record.first_name &&
        birth_date_compare(self, 2) != birth_date_compare(duplicate_record, 1) &&
        same_last_name_and_address?(duplicate_record)
    end

    def birth_date_compare(record, fallback)
      model_klass.use_birth_date? ? record.birth_date : fallback
    end

    def same_last_name_and_address?(duplicate_record)
      last_name == duplicate_record.last_name &&
        address_1 == duplicate_record.address_1 && city == duplicate_record.city &&
        state == duplicate_record.state && zipcode == duplicate_record.zipcode
    end

    def name_and_address_present?(record)
      return false unless model_klass.use_first_last_name?

      record.first_name.present? && record.last_name.present? &&
        record.address_1.present? && record.city.present? && record.state.present? && record.zipcode.present?
    end

    def duplicate_field_score(duplicate_record, attribute, weight)
      return 0 if send(attribute).blank? || duplicate_record.send(attribute).blank?

      if send(attribute).is_a?(String)
        return calc_string_weight(send(attribute), duplicate_record.send(attribute), weight)
      end

      return weight if send(attribute) == duplicate_record.send(attribute)

      0
    end

    def calc_string_weight(attribute_1, attribute_2, weight)
      if attribute_1.upcase == attribute_2.upcase
        weight
      elsif Text::Levenshtein.distance(attribute_1.upcase, attribute_2.upcase) <= 2
        weight / 2
      else
        0
      end
    end

    def set_not_duplicate(record_1, record_2)
      items = no_matches(record_1)
      items.push(record_2.id)
      items = items.uniq

      record_1.create_or_update_metadata! duplicates_not: items.to_json
      record_1.reload
      record_1.process_duplicates
    end

    def no_matches(record)
      if record.duplicate.blank? || record.duplicate.duplicates_not.blank?
        []
      else
        JSON.parse(record.duplicate.duplicates_not)
      end
    end

    def fix_duplicate(key, user)
      duplicate_record = model_klass.find_by(id: key)

      if duplicate_record.blank?
        return 'Invalid record data, perhaps something has changed or another user has resolved these duplicates.'
      end

      return 'The records are the same record.' if duplicate_record.id == id

      unless Pundit.policy!(user, duplicate_record).destroy?
        return 'You do not have authorization to merge these duplicates.'
      end

      status, message = duplicate_record.can_merge_duplicate?(self)
      return message unless status

      duplicate_record.clean_up_duplicate(self)
      duplicate_record.reload

      return nil if duplicate_record.destroy

      'Could not remove the unused duplicate record ' \
        "id #{duplicate_record.id}: #{duplicate_record.errors.full_messages.join(', ')}"
    end
end
