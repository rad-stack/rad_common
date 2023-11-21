module RadCommon
  ##
  # This is used to generate an input used for a SQL like filter
  class LikeFilter
    attr_reader :column, :input_label, :name, :input_transform

    ##
    # @param [String] column the database column that is being filtered
    def initialize(column:, input_label: nil, name: nil, input_transform: nil)
      @column = column
      @input_label = input_label
      @name = name.presence || column
      @input_transform = input_transform
    end

    def filter_view
      'like'
    end

    def searchable_name
      like_input
    end

    def like_input
      "#{name}_like"
    end

    def apply_filter(results, params)
      value = like_value(params)
      value = input_transform.call(value) if input_transform.present? && value.present?
      query = column.is_a?(Array) ? column.map { |c| "#{c} ilike :search" }.join(' OR ') : "#{column} ilike :search"
      results = results.where(query, search: "%#{value}%") if value.present?
      results
    end

    private

      def like_value(params)
        params[like_input]
      end
  end
end
