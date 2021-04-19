module DuplicateFixable
  extend ActiveSupport::Concern

  included do
    scope :duplicates_to_process, lambda {
      where('duplicates_processed_at IS NULL OR updated_at > duplicates_processed_at').order(:id)
    }

    scope :relevant_duplicates, lambda {
      where('duplicate_score IS NOT NULL AND duplicate_score >= ?', score_lower_threshold)
    }

    scope :high_duplicates, lambda {
      where('duplicate_score IS NOT NULL AND duplicate_score >= ? AND duplicate_sort <= 500', score_upper_threshold)
    }
  end

  module ClassMethods
    def score_upper_threshold
      # override as needed in models
      50
    end

    def score_lower_threshold
      # override as needed in models
      15
    end

    def use_birth_date?
      new.respond_to?(:birth_date)
    end

    def use_address?
      new.respond_to?(:address_1)
    end

    def additional_duplicate_items
      [{ name: :company_name, label: 'Company Name', type: :levenshtein, display_only: false, weight: 10 },
       { name: :email, label: 'Email', type: :string, display_only: false, weight: 20 },
       { name: :fax_number, label: 'Fax #', type: :string, display_only: false, weight: 10 },
       { name: :language_id, label: 'Language', type: :association, display_only: false, weight: 10 },
       { name: :parent_type_id, label: 'Parent Type', type: :association, display_only: false, weight: 10 },
       { name: :gender_id, label: 'Gender', type: :association, display_only: false, weight: 10 },
       { name: :locations_description, label: 'Locations', type: :string, display_only: true },
       { name: :sales_rep_id, label: 'Sales Rep', type: :association, display_only: true }]
    end

    def applicable_duplicate_items
      additional_duplicate_items.select { |item| new.respond_to?(item[:name]) }
    end
  end

  def process_duplicates
    scores = [0]
    contacts = []

    all_matches.each do |match|
      record = model_klass.find(match)
      score = duplicate_record_score(record)
      scores.push(score)
      contacts.push(id: record.id, score: score)
    end

    dupes = (contacts.to_json if contacts.count.positive?)

    # update column data, bypass callbacks and validation
    update_column :duplicates_info, dupes
    update_column :duplicate_score, scores.max.positive? ? scores.max : nil
    update_column :duplicates_processed_at, Time.current
  end

  def reset_duplicates
    # update column data, bypass callbacks and validation
    update_column :duplicates_info, nil
    update_column :duplicate_score, nil
    update_column :duplicates_processed_at, nil
    update_column :duplicates_not, nil
    update_column :duplicate_sort, 500

    process_duplicates
  end

  def duplicates
    if duplicates_info.blank?
      []
    else
      dupes = JSON.parse(duplicates_info)

      contacts = []

      dupes.each do |dupe|
        contact = model_klass.find_by(id: dupe['id'])

        if contact && (dupe['score'] >= self.class.score_lower_threshold)
          contacts.push(record: contact, score: dupe['score'])
        end
      end

      contacts.sort_by { |item| item[:score] }.reverse
    end
  end

  def not_duplicate(other_record)
    set_not_duplicate self, other_record
    set_not_duplicate other_record, self
  end

  private

    def model_klass
      self.class.to_s.constantize
    end

    def all_matches
      (name_matches +
       similar_name_matches +
       birth_date_matches +
       phone_number_matches +
       additional_item_matches).uniq - no_matches(self)
    end

    def name_matches
      model_klass.where('id <> ? AND upper(first_name) = ? AND upper(last_name) = ?',
                        id,
                        first_name.upcase,
                        last_name.upcase).pluck(:id)
    end

    def similar_name_matches
      model_klass.where('id <> ? AND levenshtein(upper(first_name), ?) <= 1 AND levenshtein(upper(last_name), ?) <= 1',
                        id,
                        first_name.upcase,
                        last_name.upcase).pluck(:id)
    end

    def birth_date_matches
      return [] unless model_klass.use_birth_date?

      query_string = 'id <> ? AND birth_date = ? AND (levenshtein(upper(first_name), ?) <= 1 OR '\
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
        item_value = attributes[item[:name]]
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

    def phone_number_matches
      model_klass.where("id <> ? AND phone_number IS NOT NULL AND phone_number <> '' AND phone_number = ?",
                        id,
                        phone_number).pluck(:id)
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
      items = [{ name: 'first_name', weight: name_weight },
               { name: 'last_name', weight: name_weight },
               { name: 'phone_number', weight: other_weight }]

      items.push(name: 'birth_date', weight: 30) if model_klass.use_birth_date?

      model_klass.applicable_duplicate_items.each do |item|
        next if item[:display_only]

        items.push(name: item[:name].to_s, weight: item[:weight]) if respond_to?(item[:name])
      end

      if model_klass.use_address?
        items += [{ name: 'city', weight: 10 },
                  { name: 'state', weight: 10 },
                  { name: 'zipcode', weight: 10 },
                  { name: 'address_1', weight: other_weight },
                  { name: 'address_2', weight: other_weight }]
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
      record.first_name.present? && record.last_name.present? &&
        record.address_1.present? && record.city.present? && record.state.present? && record.zipcode.present?
    end

    def name_weight
      # override as needed in models
      10
    end

    def other_weight
      # override as needed in models
      20
    end

    def duplicate_field_score(duplicate_record, attribute, weight)
      return 0 if self[attribute].blank? || duplicate_record[attribute].blank?
      return calc_string_weight(self[attribute], duplicate_record[attribute], weight) if self[attribute].is_a?(String)
      return weight if self[attribute] == duplicate_record[attribute]

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

      record_1.update! duplicates_not: items.to_json
      record_1.process_duplicates
    end

    def no_matches(record)
      if record.duplicates_not.blank?
        []
      else
        JSON.parse(record.duplicates_not)
      end
    end
end
