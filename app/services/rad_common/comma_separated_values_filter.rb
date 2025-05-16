module RadCommon
  ##
  # Generate a textarea input allowing user to type in comma separated values as a filter
  class CommaSeparatedValuesFilter
    attr_reader :column, :input_label, :col_class

    ##
    # @param [String] column the database column that is being filtered
    def initialize(column:, input_label: nil, col_class: nil)
      @column = column
      @input_label = input_label
      @col_class = col_class
    end

    def filter_view
      'comma_separated_values'
    end

    def searchable_name
      "#{column}_#{filter_view}"
    end

    def apply_filter(results, params)
      begin
        values = params[searchable_name].to_s.split(',').map(&:strip).compact_blank.uniq
      rescue StandardError => e
        values = nil
      end

      return results if values.blank?

      results.where(column => values)
    end

    def allow_not
      false
    end
  end
end
