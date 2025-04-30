module RadCommon
  class ArrayFilter < SearchFilter
    attr_reader :match_type

    def initialize(column:, options:, input_label: nil, multiple: false, match_type: :exact)
      super(column: column, input_label: input_label, multiple: multiple, options: options)
      @match_type = match_type
      raise ArgumentError, "Invalid match_type: #{match_type}" unless %i[exact all any].include?(match_type)
    end

    def searchable_name
      array_input
    end

    def array_input
      "#{column}_array"
    end

    def apply_filter(results, params)
      value = array_value(params)
      return results if value.blank?

      case match_type
      when :exact # The array must exactly match the provided array
        results.where(column => value)
      when :all # The record’s array must include all provided items (but can have additional items)
        results.where("#{column} @> ARRAY[?]::VARCHAR[]", value)
      when :any # The record’s array must include at least one of the provided items
        results.where("#{column} && ARRAY[?]::VARCHAR[]", value)
      end
    end

    def allow_not
      false
    end

    private

      def array_value(params)
        value = params[array_input]
        return if value.blank?

        value = value.split(',') if value.is_a?(String)
        value.map(&:strip).reject(&:blank?)
      end
  end
end
