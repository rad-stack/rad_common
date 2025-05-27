module RadCommon
  class ArrayFilter < SearchFilter
    MATCH_TYPES = %w[any all exact].freeze

    def initialize(column:, options:, input_label: nil, multiple: false)
      super(column: column, input_label: input_label, multiple: multiple, options: options)
    end

    def searchable_name
      input_name
    end

    def input_name
      "#{column}_array"
    end

    def match_types
      MATCH_TYPES
    end

    def match_type_param
      "#{searchable_name}_match_type"
    end

    def default_match_type
      'any'
    end

    def apply_filter(results, search_params)
      value = array_value(search_params)
      match_type = (search_params[match_type_param] || default_match_type).to_s
      raise ArgumentError, "Invalid match_type: #{match_type}" unless match_type.in?(MATCH_TYPES)

      return results if value.blank?

      case match_type
      when 'exact' # The array must exactly match the provided array
        results.where("#{column} @> ARRAY[?]::VARCHAR[] AND #{column} <@ ARRAY[?]::VARCHAR[]", value, value)
      when 'all' # The record’s array must include all provided items (but can have additional items)
        results.where("#{column} @> ARRAY[?]::VARCHAR[]", value)
      when 'any' # The record’s array must include at least one of the provided items
        results.where("#{column} && ARRAY[?]::VARCHAR[]", value)
      end
    end

    def allow_not
      false
    end

    private

      def array_value(params)
        value = params[input_name]
        return if value.blank?

        value = value.split(',') if value.is_a?(String)
        value.map(&:strip).reject(&:blank?)
      end
  end
end
