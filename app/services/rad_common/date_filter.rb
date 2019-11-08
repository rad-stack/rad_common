module RadCommon
  class DateFilter
    attr_reader :column
    def initialize(column:, type:)
      @column = column
    end

    def filter_view
      'date_filter'
    end

    def apply_filter(results, params)
      start_at = start_at_value(params)
      end_at = end_at_value(params)
      return results if start_at.blank? || end_at.blank?

      results.where("#{column} >= ? AND #{column} <= ? ", start_at, end_at)
    end

    def searchable_name
      [start_input, end_input]
    end

    def start_at_value(params)
      Date.parse(params[start_input]) if params[start_input].present?
    end

    def end_at_value(params)
      Date.parse(params[end_input]) if params[end_input].present?
    end

    def start_input
      "#{column}_start"
    end

    def end_input
      "#{column}_end"
    end

    # todo maybe remove these below
    def joins
      []
    end

    def multiple
      false
    end
  end
end