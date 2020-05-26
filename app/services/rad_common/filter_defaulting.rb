module RadCommon
  class FilterDefaulting
    def initialize(current_user:, search:)
      @search = search
      @current_user = current_user
    end

    def apply_defaults
      return unless @current_user.respond_to?(:filter_defaults)

      if clear_filters?
        clear_filter_defaults
      elsif @search.search_params?
        update_user_filter_defaults
      else
        load_filter_defaults
      end
    end

    private

      def search_name
        @search.search_name
      end

      def clear_filters?
        @search.params.has_key? :clear_filters
      end

      def clear_filter_defaults
        current_filter_defaults = @current_user.filter_defaults
        @search.searchable_columns_strings.each { |column| current_filter_defaults[search_name][column] = '' }
        @current_user.update_column(:filter_defaults, current_filter_defaults)
      end

      def load_filter_defaults
        return if @current_user.filter_defaults.blank? || @current_user.filter_defaults[search_name].blank?

        defaults = @current_user.filter_defaults[search_name].slice(*@search.searchable_columns_strings)
        return if defaults.blank?

        @search.params[:search] = @current_user.filter_defaults[search_name].slice(*@search.searchable_columns_strings)
      end

      def search_filter_defaults
        @current_user.filter_defaults[search_name]
      end

      def update_user_filter_defaults
        filter_defaults = @current_user.filter_defaults
        if filter_defaults.blank?
          filter_defaults = {}
          filter_defaults[search_name] = {}
        end
        @search.search_params.each do |filter_name, value|
          filter_defaults[search_name][filter_name.to_s] = value
        end
        @current_user.update_column(:filter_defaults, filter_defaults)
      end
  end
end
