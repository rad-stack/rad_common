class DuplicatesProcessor
  attr_accessor :record

  def initialize(record)
    self.record = record
  end

  def process!(bypass_notifications: false)
    items = matches # TODO: ||=

    if items.any?
      raw_score = items.first[:score]
      record.create_or_update_metadata!({ duplicates_info: items.to_json,
                                          score: raw_score.positive? ? raw_score : nil },
                                        bypass_notifications: bypass_notifications)
    else
      record.create_or_update_metadata!({ duplicates_info: nil, score: nil },
                                        bypass_notifications: bypass_notifications)
    end
  end

  def matches
    items = []

    all_matches.each do |match|
      item = model_klass.find(match)
      score = duplicate_record_score(item)
      items.push(id: item.id, score: score)
    end

    items.sort_by { |item| item[:score] }.reverse.first(100)
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

      model_klass.applicable_duplicate_items.each do |item|
        item_value = record.send(item[:name])
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
        query = query.where.not(id: record.id) if record.id.present?
        items += query.pluck(:id)
      end

      items
    end

    def duplicate_record_score(duplicate_record)
      score = 0

      all_duplicate_attributes.each do |attribute|
        score += duplicate_field_score(duplicate_record, attribute[:name], attribute[:weight])
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
      return 0 if record.send(attribute).blank? || duplicate_record.send(attribute).blank?

      if record.send(attribute).is_a?(String)
        return calc_string_weight(record.send(attribute), duplicate_record.send(attribute), weight)
      end

      return weight if record.send(attribute) == duplicate_record.send(attribute)

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
end
