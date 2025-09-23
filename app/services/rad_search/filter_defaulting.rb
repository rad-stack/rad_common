module RadSearch
  class FilterDefaulting
    def initialize(current_user:, search:, enabled:)
      @search = search
      @current_user = current_user
      @enabled = enabled
    end

    def apply_defaults
      return unless @enabled

      if clear_filters?
        clear_filter_defaults
      elsif !@search.search_params?
        load_filter_defaults
      end
    end

    def update_defaults
      return unless @enabled || @search.search_params?

      update_user_filter_defaults
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
        return unless current_filter_defaults

        current_filter_defaults[search_name] = {}
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
        filter_defaults = {} if filter_defaults.blank?
        filter_defaults[search_name] = {} if filter_defaults[search_name].blank?

        @search.search_params.each do |filter_name, value|
          filter_defaults[search_name][filter_name.to_s] = value unless @search.skip_default?(filter_name)
        end

        @current_user.update_column(:filter_defaults, filter_defaults)
      end
  end
end
