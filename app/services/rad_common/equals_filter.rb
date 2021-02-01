module RadCommon
  ##
  # This is used to generate an input used for a SQL like filter
  class EqualsFilter
    attr_reader :column, :data_type

    ##
    # @param [String] column the database column that is being filtered
    # @param [Symbol] data_type controls what the input type is based on data type of column
    def initialize(column:, data_type:)
      raise 'data_type must be either :integer or :string' if supported_data_types.exclude?(data_type)

      @column = column
      @data_type = data_type
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

      def supported_data_types
        %i[integer string]
      end
  end
end
