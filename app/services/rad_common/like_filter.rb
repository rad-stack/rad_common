module RadCommon
  ##
  # This is used to generate an input used for a SQL like filter
  class LikeFilter
    attr_reader :column, :input_label, :name

    ##
    # @param [String] column the database column that is being filtered
    def initialize(column:, input_label: nil, name: nil)
      @column = column
      @input_label = input_label
      @name = name.presence || column
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

      results = results.where("#{column} ilike ?", "%#{value.downcase}%") if value.present?
      results
    end

    private

      def like_value(params)
        params[like_input]
      end
  end
end
