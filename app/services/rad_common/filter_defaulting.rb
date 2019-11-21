module RadCommon
  class FilterDefaulting

    def initialize(current_user:, search: search)
      @search = search
      @current_user = current_user
    end

    def self.apply_defaults
      return unless @current_user.respond_to?(:filter_defaults)

      if clear_filters?
        clear_filter_defaults
      elsif search.search_params?
        update_user_filter_defaults
      else
        @search.params[:search] = load_filter_defaults
      end
    end

    private

      def clear_filters?
        @search.params.has_key? :clear_filters
      end

      def clear_filter_defaults
        current_filter_defaults = current_user.filter_defaults
        searchable_columns_strings.each { |column| current_filter_defaults[column] = '' }
        current_user.update_column(:filter_defaults, current_filter_defaults)
      end

      def load_filter_defaults
        return if @current_user.filter_defaults.blank?

        defaults = @current_user.filter_defaults.slice(*@search.searchable_columns_strings)
        return if defaults.blank?

        @current_user.filter_defaults.slice(*@search.searchable_columns_strings)
      end

      def update_user_filter_defaults
        filter_defaults = @current_user.filter_defaults
        filter_defaults = {} if filter_defaults.blank?
        @search.search_params.each do |filter_name, value|
          filter_defaults[filter_name.to_s] = value
        end
        @current_user.update_column(:filter_defaults, filter_defaults)
      end
  end
end