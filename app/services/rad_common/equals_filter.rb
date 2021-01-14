module RadCommon
  ##
  # This is used to generate an input used for a SQL like filter
  class EqualsFilter
    attr_reader :column

    ##
    # @param [String] column the database column that is being filtered
    # @param [Symbol] type the type of filter
    def initialize(column:, type:)
      @column = column
    end

    def filter_view
      'equals'
    end

    def searchable_name
      equals_input
    end

    def equals_input
      "#{column}_equals"
    end

    def apply_filter(results, params)
      value = equals_value(params)

      results = results.where("#{column} = ?", value) if value.present?
      results
    end

    private

    def equals_value(params)
      params[equals_input]
    end
  end
end
