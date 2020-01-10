module RadCommon
  class DateFilter
    attr_reader :column

    def initialize(column:, type:, start_input_label: nil, end_input_label: nil)
      @column = column
      @start_input_label = start_input_label
      @end_input_label = end_input_label
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
      start_at = start_at_value(params)
      end_at = end_at_value(params)

      results = results.where("#{results.table_name}.#{column} >= ?", start_at&.beginning_of_day) if start_at.present?
      results = results.where("#{results.table_name}.#{column} <= ?", end_at&.end_of_day) if end_at.present?
      results
    end

    private

      def start_at_value(params)
        Date.parse(params[start_input]) if params[start_input].present?
      end

      def end_at_value(params)
        Date.parse(params[end_input]) if params[end_input].present?
      end
  end
end
