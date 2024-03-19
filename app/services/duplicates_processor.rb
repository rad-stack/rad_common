class DuplicatesProcessor
  attr_accessor :record

  def initialize(record)
    self.record = record
    check_item_schema
  end

  def process!(bypass_notifications: false)
    if matches.any?
      raw_score = matches.first[:score]
      record.create_or_update_metadata!({ duplicates_info: matches.to_json,
                                          score: raw_score.positive? ? raw_score : nil },
                                        bypass_notifications: bypass_notifications)
    else
      record.create_or_update_metadata!({ duplicates_info: nil, score: nil },
                                        bypass_notifications: bypass_notifications)
    end
  end

  def matches
    @matches ||= begin
      items = []

      all_matches.each do |match|
        item = model_klass.find(match)
        score = duplicate_record_score(item)
        items.push(id: item.id, score: score)
      end

      items.sort_by { |item| item[:score] }.reverse.first(100)
    end
  end

  private

    def all_matches
      (name_matches + similar_name_matches + birth_date_matches + additional_item_matches).uniq -
        model_klass.no_matches(record)
    end

    def name_matches
      return [] unless model_klass.use_first_last_name? && first_last_name_present?

      query = model_klass.where('upper(first_name) = ? AND upper(last_name) = ?',
                                record.first_name.upcase,
                                record.last_name.upcase)

      query = query.where.not(id: record.id) if record.id.present?
      query.pluck(:id)
    end

    def similar_name_matches
      return [] unless model_klass.use_first_last_name? && first_last_name_present?

      query = model_klass.where('levenshtein(upper(first_name), ?) <= 1 AND levenshtein(upper(last_name), ?) <= 1',
                                record.first_name.upcase,
                                record.last_name.upcase)

      query = query.where.not(id: record.id) if record.id.present?
      query.pluck(:id)
    end

    def birth_date_matches
      return [] unless model_klass.use_birth_date? && model_klass.use_first_last_name? && first_last_name_present?

      query_string = 'birth_date = ? AND (levenshtein(upper(first_name), ?) <= 1 OR ' \
                     'levenshtein(upper(last_name), ?) <= 1)'

      query = model_klass.where(query_string, record.birth_date, record.first_name.upcase, record.last_name.upcase)
      query = query.where.not(id: record.id) if record.id.present?
      query.pluck(:id)
    end

    def additional_item_matches
      items = []

      applicable_duplicate_items.each do |item|
        item_value = record.send(item[:name])
        next if item[:display_only] || item_value.blank?

        query = case item[:type]
                when :association
                  association_query item, item_value
                when :levenshtein
                  levenshtein_query item, item_value.upcase
                else
                  other_query item, item_value
                end

        query = query.where.not(id: record.id) if record.id.present?
        items += query.pluck(:id)
      end

      items
    end

    def association_query(item, item_value)
      model_klass.where("#{item[:name]} IS NOT NULL AND #{item[:name]} = ?", item_value)
    end

    def levenshtein_query(item, item_value)
      model_klass.where("levenshtein(upper(#{item[:name]}), ?) <= 1", item_value)
    end

    def other_query(item, item_value)
      case item[:name]
      when 'email'
        email_query item_value
      when 'phone_number'
        phone_query item_value
      when 'mobile_phone'
        mobile_phone_query item_value
      else
        model_klass.where("#{item[:name]} IS NOT NULL AND #{item[:name]} <> '' AND #{item[:name]} = ?", item_value)
      end
    end

    def email_query(item_value)
      if model_klass.use_email_2?
        model_klass.where('email IS NOT NULL AND (email = ? OR email_2 = ?)', item_value, item_value)
      else
        model_klass.where('email IS NOT NULL AND email = ?', item_value)
      end
    end

    def phone_query(item_value)
      if model_klass.use_phone_number_2? && model_klass.use_mobile_phone?
        model_klass.where('phone_number IS NOT NULL AND (phone_number = ? OR phone_number_2 = ? OR mobile_phone = ?)', item_value, item_value, item_value)
      elsif model_klass.use_phone_number_2?
        model_klass.where('phone_number IS NOT NULL AND (phone_number = ? OR phone_number_2 = ?)', item_value, item_value)
      elsif model_klass.use_mobile_phone?
        model_klass.where('phone_number IS NOT NULL AND (phone_number = ? OR mobile_phone = ?)', item_value, item_value)
      else
        model_klass.where('phone_number IS NOT NULL AND phone_number = ?', item_value)
      end
    end

    def mobile_phone_query(item_value)
      model_klass.where('mobile_phone IS NOT NULL AND (mobile_phone = ? OR phone_number = ? OR phone_number_2 = ?)', item_value, item_value, item_value)
    end

    def duplicate_record_score(duplicate_record)
      score = 0

      all_duplicate_attributes.each do |attribute|
        this_score = duplicate_field_score(duplicate_record, attribute[:name], attribute[:weight])
        puts "#{attribute}: #{this_score}" # TODO: create an option to formalize this debug mode
        score += this_score
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

      applicable_duplicate_items.each do |item|
        next if item[:display_only]

        items.push(name: item[:name], weight: item[:weight]) if record.respond_to?(item[:name])
      end

      if model_klass.use_address?
        items += [{ name: 'city', weight: 10 },
                  { name: 'state', weight: 10 },
                  { name: 'zipcode', weight: 10 },
                  { name: 'address_1', weight: record.duplicate_other_weight },
                  { name: 'address_2', weight: record.duplicate_other_weight }]
      end

      items
    end

    def duplicate_field_score(duplicate_record, attribute, weight)
      return 0 if record.send(attribute).blank?

      if record.send(attribute).is_a?(String)
        return calc_string_weight(record, duplicate_record, attribute, weight)
      end

      return weight if record.send(attribute) == duplicate_record.send(attribute)

      0
    end

    def calc_string_weight(record, duplicate_record, field_name, weight)
      case field_name.to_s
      when 'email'
        calc_email_weight record, duplicate_record, weight
      when 'phone_number'
        calc_phone_number_weight record, duplicate_record, weight
      when 'mobile_phone'
        calc_mobile_phone_weight record, duplicate_record, weight
      else
        attribute_1 = record.send(field_name)
        attribute_2 = duplicate_record.send(field_name)

        if attribute_1.blank? || attribute_2.blank?
          0
        elsif attribute_1.upcase == attribute_2.upcase
          weight
        elsif levenshtein_compare?(attribute_1, attribute_2)
          weight / 2
        else
          0
        end
      end
    end

    def calc_email_weight(record, duplicate_record, weight)
      if email_compare?(record, duplicate_record)
        weight
      elsif levenshtein_email_compare?(record, duplicate_record)
        weight / 2
      else
        0
      end
    end

    def calc_phone_number_weight(record, duplicate_record, weight)
      if phone_number_compare?(record, duplicate_record)
        weight
      elsif levenshtein_phone_number_compare?(record, duplicate_record)
        weight / 2
      else
        0
      end
    end

    def calc_mobile_phone_weight(record, duplicate_record, weight)
      if mobile_phone_compare?(record, duplicate_record)
        weight
      elsif levenshtein_mobile_phone_compare?(record, duplicate_record)
        weight / 2
      else
        0
      end
    end

    def email_compare?(record, duplicate_record)
      if model_klass.use_email_2?
        record.email == duplicate_record.email || record.email == record.email_2
      else
        record.email == duplicate_record.email
      end
    end

    def phone_number_compare?(record, duplicate_record)
      if model_klass.use_phone_number_2? && model_klass.use_mobile_phone?
        record.phone_number == duplicate_record.phone_number || record.phone_number == duplicate_record.phone_number_2 || record.phone_number == duplicate_record.mobile_phone
      elsif model_klass.use_phone_number_2?
        record.phone_number == duplicate_record.phone_number || record.phone_number == duplicate_record.phone_number_2
      elsif model_klass.use_mobile_phone?
        record.phone_number == duplicate_record.phone_number || record.phone_number == duplicate_record.mobile_phone
      else
        record.phone_number == duplicate_record.phone_number
      end
    end

    def mobile_phone_compare?(record, duplicate_record)
      if model_klass.use_phone_number? && model_klass.use_phone_number_2?
        record.mobile_phone == duplicate_record.mobile_phone || record.mobile_phone == duplicate_record.phone_number || record.mobile_phone == duplicate_record.phone_number_2
      elsif model_klass.use_phone_number?
        record.mobile_phone == duplicate_record.mobile_phone || record.mobile_phone == duplicate_record.phone_number
      elsif model_klass.use_phone_number_2?
        record.mobile_phone == duplicate_record.mobile_phone || record.mobile_phone == duplicate_record.phone_number_2
      else
        record.mobile_phone == duplicate_record.mobile_phone
      end
    end

    def levenshtein_email_compare?(record, duplicate_record)
      if model_klass.use_email_2?
        levenshtein_compare?(record.email, duplicate_record.email) || levenshtein_compare?(record.email, record.email_2)
      else
        levenshtein_compare?(record.email, duplicate_record.email)
      end
    end

    def levenshtein_phone_number_compare?(record, duplicate_record)
      if model_klass.use_phone_number_2? && model_klass.use_mobile_phone?
        levenshtein_compare?(record.phone_number, duplicate_record.phone_number) || levenshtein_compare?(record.phone_number, duplicate_record.phone_number_2) || levenshtein_compare?(record.phone_number, duplicate_record.mobile_phone)
      elsif model_klass.use_phone_number_2?
        levenshtein_compare?(record.phone_number, duplicate_record.phone_number) || levenshtein_compare?(record.phone_number, duplicate_record.phone_number_2)
      elsif model_klass.use_mobile_phone?
        levenshtein_compare?(record.phone_number, duplicate_record.phone_number) || levenshtein_compare?(record.phone_number, duplicate_record.mobile_phone)
      else
        levenshtein_compare?(record.phone_number, duplicate_record.phone_number)
      end
    end

    def levenshtein_mobile_phone_compare?(record, duplicate_record)
      if model_klass.use_phone_number? && model_klass.use_phone_number_2?
        levenshtein_compare?(record.mobile_phone, duplicate_record.mobile_phone) || levenshtein_compare?(record.mobile_phone, duplicate_record.phone_number) || levenshtein_compare?(record.mobile_phone, duplicate_record.phone_number_2)
      elsif model_klass.use_phone_number?
        levenshtein_compare?(record.mobile_phone, duplicate_record.mobile_phone) || levenshtein_compare?(record.mobile_phone, duplicate_record.phone_number)
      elsif model_klass.use_phone_number_2?
        levenshtein_compare?(record.mobile_phone, duplicate_record.mobile_phone) || levenshtein_compare?(record.mobile_phone, duplicate_record.phone_number_2)
      else
        levenshtein_compare?(record.mobile_phone, duplicate_record.mobile_phone)
      end
    end

    def levenshtein_compare?(string_1, string_2)
      return false if string_1.blank? || string_2.blank?

      Text::Levenshtein.distance(string_1.upcase, string_2.upcase) <= 2
    end

    def first_last_name_present?
      record.first_name.present? && record.last_name.present?
    end

    def duplicate_first_name_weight
      record.duplicate_model_config[:first_name_weight].presence || 10
    end

    def duplicate_last_name_weight
      record.duplicate_model_config[:last_name_weight].presence || 10
    end

    def model_klass
      @model_klass ||= record.class.to_s.constantize
    end

    def applicable_duplicate_items
      @applicable_duplicate_items ||= model_klass.applicable_duplicate_items
    end

    def check_item_schema
      applicable_duplicate_items.each { |item| raise item[:name].to_s unless item[:name].is_a?(String) }
    end
end
