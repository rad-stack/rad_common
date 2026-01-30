module RadSearch
  ##
  # This is used to generate an input used for a SQL like filter
  class LikeFilter
    MATCH_TYPES = %w[contains exact starts_with ends_with does_not_contain does_not_start_with does_not_end_with].freeze
    attr_reader :column, :input_label, :col_class, :name, :input_transform, :default_value

    ##
    # @param [String] column the database column that is being filtered
    def initialize(column:, input_label: nil, col_class: nil, name: nil, input_transform: nil, default_value: nil)
      @column = column
      @input_label = input_label.presence || column.to_s.titleize
      @col_class = col_class
      @name = name.presence || column
      @input_transform = input_transform
      @default_value = default_value
    end

    def filter_view
      'like'
    end

    def searchable_name
      input_name
    end

    def input_name
      "#{name}_like"
    end

    def apply_filter(results, search_params)
      value = like_value(search_params)
      value = input_transform.call(value) if input_transform.present? && value.present?
      match_type = (search_params[match_type_param] || default_match_type).to_s
      raise 'Invalid match match type' unless match_type.in?(MATCH_TYPES)

      return if value.blank?

      build_query(results, value, match_type)
    end

    def build_query(results, value, match_type)
      case match_type
      when 'contains'
        results.where("#{column} ilike ?", "%#{value}%")
      when 'exact'
        results.where("#{column} = ?", value.to_s)
      when 'does_not_contain'
        results.where.not("#{column} ilike ?", "%#{value}%")
      when 'starts_with'
        results.where("#{column} ilike ?", "#{value}%")
      when 'does_not_start_with'
        results.where.not("#{column} ilike ?", "#{value}%")
      when 'ends_with'
        results.where("#{column} ilike ?", "%#{value}")
      when 'does_not_end_with'
        results.where.not("#{column} ilike ?", "%#{value}")
      end
    end

    def allow_not
      false
    end

    def match_types
      MATCH_TYPES
    end

    def match_type_param
      "#{searchable_name}_match_type"
    end

    def default_match_type
      'contains'
    end

    private

      def like_value(params)
        search_empty = params.blank? || !params.has_key?(input_name)
        return @default_value.to_s if search_empty && @default_value

        params[input_name]
      end
  end
end
