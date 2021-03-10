module RadCommon
  ##
  # This is used to generate a hidden input to pass url parameters to query
  class HiddenFilter
    attr_reader :name
    ##
    # @param [String] name the input name for hidden input
    def initialize(name:, input_label: nil)
      @name = name
    end

    def filter_view
      'hidden'
    end

    def searchable_name
      hidden_input
    end

    def hidden_input
      @name
    end

    def apply_filter(results, params)
      # For now do nothing with this
      results
    end

    def col_class
      'd-none'
    end

    def skip_default?
      true
    end
  end
end
