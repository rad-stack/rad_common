class DuplicatesMatcher
  attr_accessor :record

  def initialize(record)
    self.record = record
  end

  def matches
    contacts = []

    all_matches.each do |match|
      item = model_klass.find(match)
      score = record.duplicate_record_score(item)
      contacts.push(id: item.id, score: score)
    end

    contacts.sort_by { |item| item[:score] }.reverse.first(100)
  end

  private

    def all_matches
      (name_matches + similar_name_matches + birth_date_matches + additional_item_matches).uniq - model_klass.no_matches(record)
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

    def first_last_name_present?
      record.first_name.present? && record.last_name.present?
    end

    def model_klass
      @model_klass ||= record.class.to_s.constantize
    end
end
