module RadSearch
  ##
  # This is a common search pattern to be used within the UI to help filter, display, and sorts results to be displayed within the UI
  class Search
    attr_reader :params, :current_user, :auto_hide, :defaulting, :search_preference

    delegate :toggle_behavior, to: :search_preference

    ##
    # @param [ActiveRecord_Relation] query The base query to start the search off with
    # @param [Array] filters An array of filters to be displayed at the top of the search. {SearchFilter}, {DateFilter}, or {LikeFilter}
    # @param [Array optional] sort_columns An array of columns to sort the query by. See {Sorting} for more details.
    # @param [User] current_user the current user running the query
    # @param [Hash] params the url params from the current url
    # @param [String optional] search_name an identifying named used for storing user defaults. Only required when user defaults enabled and not using a custom search class
    # @param [Boolean optional] sticky filters (aka FilterDefaulting) to remember user selections.
    #   nil: use existing preference, false: disable regardless of preference, true: enable by default
    def initialize(query:, filters:, current_user:, params:, sort_columns: nil, search_name: nil, sticky_filters: nil,
                   auto_hide: false)
      if sticky_filters && search_name.nil? && self.class.to_s == 'RadSearch::Search'
        raise 'search_name is required when not using a custom search class'
      end

      @results = query
      @auto_hide = auto_hide
      @current_user = current_user
      @params = params
      @search_name = search_name
      @filtering = Filtering.new(filters: filters, search: self)

      @search_preference = SearchPreference.find_or_initialize_by(
        user: current_user,
        search_class: search_name || self.class.to_s
      )
      @search_preference.set_defaults(sticky_filters: sticky_filters)
      @defaulting = FilterDefaulting.new(current_user: current_user,
                                         search: self,
                                         enabled: effective_sticky_filters(sticky_filters, @search_preference))
      @defaulting.apply_defaults
      @sorting = Sorting.new(sort_columns: sort_columns, search: self)
    end

    def search_name
      @search_name || self.class.to_s
    end

    def results
      maybe_save_filters
      retrieve_results
    end

    def valid?
      @filtering.validate_params
    end

    def invalid?
      !valid?
    end

    def errors
      @filtering.errors.uniq + saved_filter_errors
    end

    def error_messages
      errors.join(', ')
    end

    def sort_columns
      @sorting.sort_columns
    end

    def sort_column
      @sorting.sort_column
    end

    def sort_direction
      @sorting.sort_direction
    end

    # TODO: possibly remove this method, see Task 2925
    def sort_clause(record_class)
      @sorting.sort_clause record_class
    end

    def search_params?
      params.has_key? :search
    end

    def search_params
      search_params? ? params.require(:search).permit(permitted_searchable_columns + %i[sort direction]) : {}
    end

    def page_size_param
      params.dig(:search, :page_size)&.to_i || 25
    end

    def blank?(column)
      val = selected_value(column)
      val.is_a?(Array) ? val.all?(&:blank?) : val.blank?
    end

    def default_value?(column)
      filter = @filtering.filter(column)

      return blank?(column) unless filter.default_value

      val = selected_value(column)
      return true if val.nil?
      return false if blank?(column)
      return false if filter.default_value.nil?
      return default_multi_select_value?(filter, val) if val.is_a?(Array)

      val.to_s == filter.default_value.to_s
    end

    def default_multi_select_value?(filter, value)
      value = value.compact_blank
      default_value = filter.default_value
      default_value = default_value.is_a?(Array) ? default_value.compact_blank : [default_value.to_s]

      value.sort == default_value.sort
    end

    def skip_default?(name)
      filter = @filtering.filter(name)
      return false unless filter.respond_to?(:skip_default?)

      filter.skip_default?
    end

    def selected_value(column)
      search_params[column]
    end

    def searchable_columns_strings
      searchable_columns.map(&:to_s)
    end

    def filters
      @filtering.filters
    end

    def saved_filters
      @saved_filters ||= Pundit.policy_scope(current_user, SavedSearchFilter).where(search_class: self.class.name)
    end

    def applied_saved_filter
      return if search_params[:applied_filter].blank?

      @applied_saved_filter ||= SavedSearchFilter.find(search_params[:applied_filter])
    end

    def saved_filter_errors
      @saved_filter_errors ||= []
    end

    private

      def retrieve_results
        if valid?
          @defaulting.update_defaults
          @results = @filtering.apply_filtering(@results)
          @results = @sorting.apply_sorting(@results)
        else
          @results = @results.none
        end
      end

      def searchable_columns
        filters.map(&:searchable_name).flatten
      end

      def permitted_searchable_columns
        # we need to make sure any params that are an array value ( multiple select ) go to the bottom for
        # permit to work
        columns = filters.sort_by { |f| f.respond_to?(:multiple) && f.multiple ? 1 : 0 }
        columns.map { |f|
          not_filter = "#{f.searchable_name}_not" if f.allow_not
          match_type = f.match_type_param if f.is_a?(LikeFilter) || f.is_a?(ArrayFilter)
          if f.respond_to?(:multiple) && f.multiple
            [not_filter, match_type, { f.searchable_name => [] }].compact
          else
            [not_filter, match_type, f.searchable_name].compact
          end
        }.flatten + %i[applied_filter saved_name]
      end

      def maybe_save_filters
        filter_name = search_params[:saved_name]
        return unless RadConfig.saved_search_filters_enabled? && filter_name.present?

        filter = SavedSearchFilter.find_or_initialize_by(name: filter_name,
                                                         user: current_user,
                                                         search_class: self.class.name)
        filter.search_filters = search_params.to_h.compact_blank
        if filter.save
          params[:search][:applied_filter] = filter.id
        else
          saved_filter_errors << "Filter \"#{filter}\" could not be saved: #{filter.errors.full_messages.to_sentence}"
        end
      end

      def effective_sticky_filters(search_option, search_preference)
        if search_option == false
          false
        elsif search_preference.persisted?
          search_preference.sticky_filters
        else
          search_option
        end
      end

      def created_by_filter
        { input_label: 'Created By',
          scope: :for_created_by,
          options: [['Active', active_users], ['Inactive', inactive_users]],
          grouped: true,
          blank_value_label: 'All Users' }
      end

      def active_users
        Pundit.policy_scope!(current_user, User).active.sorted
      end

      def inactive_users
        Pundit.policy_scope!(current_user, User).inactive.sorted
      end
  end
end
