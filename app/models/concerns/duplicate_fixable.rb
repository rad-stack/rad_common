module DuplicateFixable
  extend ActiveSupport::Concern

  SCORE_UPPER_THRESHOLD = 50
  SCORE_LOWER_THRESHOLD = 15

  included do
    scope :duplicates_to_process, lambda {
      where('duplicates_processed_at IS NULL OR updated_at > duplicates_processed_at').order(:id)
    }

    scope :relevant_duplicates, lambda {
      where('duplicate_score IS NOT NULL AND duplicate_score >= ?', DuplicateFixable::SCORE_LOWER_THRESHOLD)
    }

    scope :high_duplicates, lambda {
      where('duplicate_score IS NOT NULL AND duplicate_score >= ? AND duplicate_sort <= 500',
            DuplicateFixable::SCORE_UPPER_THRESHOLD)
    }
  end

  module ClassMethods
    def use_birth_date?
      method_defined?('birth_date')
    end

    def use_company_name?
      method_defined?('company_name')
    end

    def use_fax_number?
      method_defined?('fax_number')
    end

    def use_sales_rep?
      method_defined?('sales_rep_id')
    end

    def use_address?
      method_defined?('address_1')
    end

    def use_locations?
      to_s == 'Prescriber'
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
        contacts.push(record: contact, score: dupe['score']) if contact && (dupe['score'] >= SCORE_LOWER_THRESHOLD)
      end

      contacts.sort_by { |item| item[:score] }.reverse
    end
  end

  def not_duplicate(other_patient)
    set_not_duplicate self, other_patient
    set_not_duplicate other_patient, self
  end

  private

    def model_klass
      self.class.to_s.constantize
    end

    def all_matches
      (name_matches +
       similar_name_matches +
       birth_date_matches +
       fax_number_matches +
       company_name_matches +
       phone_number_matches +
       email_matches).uniq - no_matches(self)
    end

    def name_matches
      model_klass.where('id <> ? AND upper(first_name) = ? AND upper(last_name) = ?',
                        id,
                        first_name.upcase,
                        last_name.upcase).map(&:id)
    end

    def similar_name_matches
      model_klass.where('id <> ? AND levenshtein(upper(first_name), ?) <= 1 AND levenshtein(upper(last_name), ?) <= 1',
                        id,
                        first_name.upcase,
                        last_name.upcase).map(&:id)
    end

    def birth_date_matches
      return [] unless model_klass.use_birth_date?

      query_string = 'id <> ? AND birth_date = ? AND (levenshtein(upper(first_name), ?) <= 1 OR '\
                     'levenshtein(upper(last_name), ?) <= 1)'

      model_klass.where(query_string,
                        id,
                        birth_date,
                        first_name.upcase,
                        last_name.upcase).map(&:id)
    end

    def company_name_matches
      return [] unless model_klass.use_company_name? && company_name.present?

      model_klass.where('id <> ? AND levenshtein(upper(company_name), ?) <= 1', id, company_name.upcase).map(&:id)
    end

    def fax_number_matches
      return [] unless model_klass.use_fax_number?

      model_klass.where("id <> ? AND fax_number IS NOT NULL AND fax_number <> '' AND fax_number = ?",
                        id,
                        fax_number).map(&:id)
    end

    def phone_number_matches
      model_klass.where("id <> ? AND phone_number IS NOT NULL AND phone_number <> '' AND phone_number = ?",
                        id,
                        phone_number).map(&:id)
    end

    def email_matches
      model_klass.where("id <> ? AND email IS NOT NULL AND email <> '' AND upper(email) = ?",
                        id,
                        email.to_s.upcase).map(&:id)
    end

    def duplicate_record_score(duplicate_record)
      score = 0

      attributes = [{ name: 'first_name', weight: name_weight },
                    { name: 'last_name', weight: name_weight },
                    { name: 'phone_number', weight: other_weight },
                    { name: 'email', weight: 20 }]

      attributes.push(name: 'birth_date', weight: 30) if model_klass.use_birth_date?
      attributes.push(name: 'company_name', weight: 10) if model_klass.use_company_name?
      attributes.push(name: 'fax_number', weight: 10) if model_klass.use_fax_number?

      if model_klass.use_address?
        attributes += [{ name: 'city', weight: 10 },
                       { name: 'state', weight: 10 },
                       { name: 'zipcode', weight: 10 },
                       { name: 'address_1', weight: other_weight },
                       { name: 'address_2', weight: other_weight }]
      end

      attributes.each do |attribute|
        score += duplicate_field_score(duplicate_record, attribute[:name], attribute[:weight])
      end

      score = 5 if family_member_same_home?(duplicate_record)

      ((score / attributes.pluck(:weight).sum.to_f) * 100).to_i
    end

    def family_member_same_home?(duplicate_record)
      duplicate_birth_date = (model_klass.use_birth_date? ? duplicate_record.birth_date : 1)
      self_birth_date = (model_klass.use_birth_date? ? birth_date : 2)

      model_klass.use_address? && duplicate_birth_date && duplicate_record.first_name.present? &&
        first_name.present? && last_name.present? && address_1.present? && city.present? && state.present? &&
        zipcode.present? && self_birth_date && first_name != duplicate_record.first_name &&
        self_birth_date != duplicate_birth_date && last_name == duplicate_record.last_name &&
        address_1 == duplicate_record.address_1 && city == duplicate_record.city &&
        state == duplicate_record.state && zipcode == duplicate_record.zipcode
    end

    def name_weight
      instance_of?(Prescriber) ? 20 : 10
    end

    def other_weight
      instance_of?(Prescriber) ? 10 : 20
    end

    def duplicate_field_score(duplicate_patient, attribute, weight)
      return 0 if self[attribute].blank? || duplicate_patient[attribute].blank?

      if self[attribute].is_a?(String)
        if self[attribute].upcase == duplicate_patient[attribute].upcase
          weight
        elsif Text::Levenshtein.distance(self[attribute].upcase, duplicate_patient[attribute].upcase) <= 2
          weight / 2
        else
          0
        end
      elsif self[attribute] == duplicate_patient[attribute]
        weight
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
