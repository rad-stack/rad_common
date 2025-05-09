module RadCommon
  ##
  # This is used to generate an input used for a SQL like filter
  class LikeFilter
    attr_reader :column, :input_label, :col_class, :name, :input_transform, :allow_not

    ##
    # @param [String] column the database column that is being filtered
    def initialize(column:, input_label: nil, col_class: nil, name: nil, input_transform: nil, allow_not: false)
      @column = column
      @input_label = input_label
      @col_class = col_class
      @name = name.presence || column
      @input_transform = input_transform
      @allow_not = allow_not
    end

    def filter_view
      'like'
    end

    def searchable_name
      like_input
    end

    def not_value?(search_params)
      allow_not && search_params && search_params["#{searchable_name}_not"] == '1'
    end

    def like_input
      "#{name}_like"
    end

    def apply_filter(results, search_params)
      value = like_value(search_params)
      value = input_transform.call(value) if input_transform.present? && value.present?
      return results if value.blank?

      if not_value?(search_params)
        results.where("#{column} NOT ilike ?", "%#{value}%")
      else
        results.where("#{column} ilike ?", "%#{value}%")
      end
    end

    private

      def like_value(params)
        params[like_input]
      end
  end
end
