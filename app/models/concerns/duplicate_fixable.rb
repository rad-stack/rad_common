module DuplicateFixable
  extend ActiveSupport::Concern

  included do
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
       { name: :mobile_phone,
         label: 'Mobile Phone',
         type: :string,
         display_only: false,
         weight: new.duplicate_other_weight },
       { name: :fax_number,
         label: 'Fax #',
         type: :string,
         display_only: false,
         weight: 10 }] + configured_duplicate_items
    end

    def applicable_duplicate_items
      items = additional_duplicate_items.select { |item| new.respond_to?(item[:name]) || item[:fields_to_match].present? }
      fields_to_match = items.select { |item| item[:fields_to_match].present? }
                             .pluck(:fields_to_match).flatten.uniq
      items.reject { |item| fields_to_match.include?(item[:name].to_s) }
    end

    def notify_high_duplicates
      all_records = all.size
      return unless all_records.positive?

      duplicate_records = high_duplicates.count
      percentage = (duplicate_records / (all_records * 1.0))
      return unless percentage > duplicate_notify_threshold

      Notifications::HighDuplicatesNotification.main.notify!(threshold: duplicate_notify_threshold,
                                                             percentage: percentage,
                                                             model_name: to_s)
    end

    def duplicate_notify_threshold
      new.duplicate_model_config[:notify_threshold].presence || 0.01
    end
  end

  def process_duplicates
    contacts = duplicate_matches

    if contacts.any?
      raw_score = contacts.first[:score]
      create_or_update_metadata! duplicates_info: contacts.to_json, score: raw_score.positive? ? raw_score : nil
    else
      create_or_update_metadata! duplicates_info: nil, score: nil
    end
  end

  def duplicate_fields
    fields = {}

    fields['Name'] = "#{first_name}, #{last_name}" if model_klass.use_first_last_name?
    fields['Address'] = full_address if model_klass.use_address? && respond_to?(:full_address)
    fields['Birth Date'] = birth_date.presence if model_klass.use_birth_date?
    model_klass.applicable_duplicate_items.each { |item| fields[item[:label]] = duplicate_item_display(item) }

    fields
  end

  def duplicate_item_display(item)
    return send(item[:name]) unless item[:type] == :association

    association = item[:name].to_s.gsub('_id', '')
    send(association)&.to_s
  end

  def find_duplicates
    contacts = duplicate_matches.reject { |contact| contact[:score] < self.class.score_lower_threshold }
    return if contacts.empty?

    contacts.map { |contact| self.class.find(contact[:id]) }
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

    def duplicate_matches
      contacts = []

      all_matches.each do |match|
        record = model_klass.find(match)
        score = duplicate_record_score(record)
        contacts.push(id: record.id, score: score)
      end

      contacts.sort_by { |item| item[:score] }.reverse.first(100)
    end

    def name_matches
      return [] unless model_klass.use_first_last_name? && first_last_name_present?

      query = model_klass.where('upper(first_name) = ? AND upper(last_name) = ?',
                                first_name.upcase,
                                last_name.upcase)
      query = query.where.not(id: id) if id.present?
      query.pluck(:id)
    end

    def similar_name_matches
      return [] unless model_klass.use_first_last_name? && first_last_name_present?

      query = model_klass.where('levenshtein(upper(first_name), ?) <= 1 AND levenshtein(upper(last_name), ?) <= 1',
                                first_name.upcase,
                                last_name.upcase)
      query = query.where.not(id: id) if id.present?
      query.pluck(:id)
    end

    def birth_date_matches
      return [] unless model_klass.use_birth_date? && model_klass.use_first_last_name? && first_last_name_present?

      query_string = 'birth_date = ? AND (levenshtein(upper(first_name), ?) <= 1 OR ' \
                     'levenshtein(upper(last_name), ?) <= 1)'

      query = model_klass.where(query_string,
                                birth_date,
                                first_name.upcase,
                                last_name.upcase)
      query = query.where.not(id: id) if id.present?
      query.pluck(:id)
    end

    def additional_item_matches
      items = []

      model_klass.applicable_duplicate_items.each do |item|
        if item[:fields_to_match].present?
          item_values = item[:fields_to_match].map { |f| send(f) }.compact
                                              .map { |f| "'#{f}'" }.join(', ')
          sql = item[:fields_to_match].map { |field|
            "#{field} IS NOT NULL AND #{field} <> '' AND #{field} IN (#{item_values})"
          }.join(' OR ')
          query = model_klass.where(sql)
        else
          item_value = send(item[:name])
          next if item[:display_only] || item_value.blank?

          query = case item[:type]
                  when :association
                    "#{item[:name]} IS NOT NULL AND #{item[:name]} = ?"
                  when :levenshtein
                    "levenshtein(upper(#{item[:name]}), ?) <= 1"
                  else
                    "#{item[:name]} IS NOT NULL AND #{item[:name]} <> '' AND #{item[:name]} = ?"
                  end

          check_value = item[:type] == :levenshtein ? item_value.upcase : item_value
          query = model_klass.where(query, check_value)
        end
        query = query.where.not(id: id) if id.present?
        items += query.pluck(:id)
      end

      items
    end

    def duplicate_record_score(duplicate_record)
      score = 0

      all_duplicate_attributes.each do |attribute|
        score += duplicate_field_score(duplicate_record, attribute[:name], attribute[:weight],
                                       attribute[:fields_to_match])
      end

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
        next unless item[:fields_to_match].present? || respond_to?(item[:name])

        dupe_attr_info = { name: item[:name], weight: item[:weight] }
        dupe_attr_info[:fields_to_match] = item[:fields_to_match] if item[:fields_to_match].present?
        items.push(dupe_attr_info)
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

    def duplicate_field_score(duplicate_record, attribute, weight, fields_to_match)
      if fields_to_match.present?
        field_values = fields_to_match.map { |f| send(f) }.compact
        return fields_to_match.sum do |field|
          field_values.map { |val| calc_string_weight(val, duplicate_record.send(field), weight) }.max
        end
      end

      return 0 if send(attribute).blank? || duplicate_record.send(attribute).blank?

      if send(attribute).is_a?(String)
        return calc_string_weight(send(attribute), duplicate_record.send(attribute), weight)
      end

      return weight if send(attribute) == duplicate_record.send(attribute)

      0
    end

    def calc_string_weight(attribute_1, attribute_2, weight)
      return 0 unless attribute_2

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

    def first_last_name_present?
      first_name.present? && last_name.present?
    end
end
