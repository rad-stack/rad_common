module RadCommon
  ##
  # This is used to generate a date filter input, which filters a date column between a start date and end date range.
  class DateFilter
    attr_reader :column, :errors, :default_start_value, :default_end_value

    ##
    # @param [Symbol] column the database column that is being filtered
    # @param [String optional] start_input_label by default the start input label for the input is determined
    #   by the column name but you can override that by specifying it here
    # @param [String optional] end_input_label by default the end input label for the input is determined
    #   by the column name but you can override that by specifying it here
    # @param [Boolean optional] custom when true we assume the actual filtering is being taken care of
    #   in a custom fashion and we skip applying the filter.
    # @param [Date optional] default_start_value default start at value for the date filter
    # @param [Date optional] default_end_value default end at value for the date filter
    #
    # @example
    #   { column: :created_at, type: RadCommon::DateFilter, start_input_label: 'The Start', end_input_label: 'The End' }
    def initialize(column:, type:, start_input_label: nil, end_input_label: nil, custom: false,
                   default_start_value: nil, default_end_value: nil)
      @column = column
      @start_input_label = start_input_label
      @end_input_label = end_input_label
      @default_start_value = default_start_value
      @default_end_value = default_end_value
      @custom = custom
      @errors = []
    end

    def filter_view
      'date'
    end

    def searchable_name
      [start_input, end_input]
    end

    def start_input
      "#{column}_start"
    end

    def end_input
      "#{column}_end"
    end

    def start_input_label
      @start_input_label || "#{column.to_s.titleize} Start"
    end

    def end_input_label
      @end_input_label || "#{column.to_s.titleize} End"
    end

    def apply_filter(results, params)
      return results if @custom

      start_at = start_at_value(params)
      end_at = end_at_value(params)

      start_at = start_at.beginning_of_day if start_at && datetime_column?(results)
      end_at = end_at.end_of_day if end_at && datetime_column?(results)

      results = results.where("#{query_column(results)} >= ?", start_at) if start_at.present?
      results = results.where("#{query_column(results)} <= ?", end_at) if end_at.present?
      results
    end

    def query_column(results)
      return column if column.respond_to?(:split) && column.split('.').length > 1

      "#{results.table_name}.#{searchable_name}"
    end

    def validate_params(params)
      return true if @custom

      begin
        if start_at_value(params).present? && end_at_value(params).present? &&
           start_at_value(params) > end_at_value(params)
          errors << 'Start at date must before end date'
          return false
        end
      rescue ArgumentError
        errors << "Invalid date entered for #{column}"
        return false
      end

      true
    end

    private

      def datetime_column?(results)
        results.model.column_for_attribute(@column).type == :datetime
      end

      def start_at_value(params)
        return @default_start_value.to_date if params.blank? && @default_start_value

        Date.parse(params[start_input]) if params[start_input].present?
      end

      def end_at_value(params)
        return @default_end_value.to_date if params.blank? && @default_end_value

        Date.parse(params[end_input]) if params[end_input].present?
      end
  end
end
