module RadSearch
  class FilterDefaulting
    attr_reader :enabled

    def initialize(current_user:, search:, enabled:)
      @search = search
      @current_user = current_user
      @enabled = enabled
    end

    def apply_defaults
      return unless @enabled

      if clear_filters?
        clear_filter_defaults
      elsif !user_has_searched?
        load_filter_defaults
      end
    end

    def update_defaults
      return unless @enabled && @search.search_params?

      update_user_filter_defaults
    end

    private

      def search_name
        @search.search_name
      end

      def clear_filters?
        @search.params.has_key? :clear_filters
      end

      def user_has_searched?
        return false unless @search.search_params?

        @search.filters.any? do |filter|
          next if filter.respond_to?(:skip_default?) && filter.skip_default?

          value = @search.search_params[filter.searchable_name]
          if value.is_a?(Array)
            value.reject(&:blank?).present?
          else
            value.present?
          end
        end
      end

      def clear_filter_defaults
        preference = SearchPreference.find_by(user: @current_user, search_class: search_name)
        return unless preference

        preference.update(search_filters: {})
      end

      def load_filter_defaults
        preference = SearchPreference.find_by(user: @current_user, search_class: search_name)
        return unless preference

        defaults = preference.search_filters.slice(*@search.searchable_columns_strings)
        return if defaults.blank?

        symbolized_defaults = defaults.deep_symbolize_keys
        @search.params[:search] = ActionController::Parameters.new(symbolized_defaults)
      end

      def update_user_filter_defaults
        preference = SearchPreference.find_or_initialize_by(user: @current_user, search_class: search_name)

        @search.search_params.each do |filter_name, value|
          preference.search_filters[filter_name.to_s] = value unless @search.skip_default?(filter_name)
        end

        preference.save
      end
  end
end
