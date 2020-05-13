module RadCommon
  ##
  # This is a common search pattern to be used within the UI to help filter, display, and sorts results to be displayed within the UI
  class Search
    attr_reader :params, :current_user

    ##
    # @param [ActiveRecord_Relation] query The base query to start the search off with
    # @param [Array] filters An array of filters to be displayed at the top of the search. {SearchFilter}, {DateFilter}, or {LikeFilter}
    # @param [Array optional] sort_columns An array of columns to sort the query by. See {Sorting} for more details.
    # @param [User] current_user the current user running the query
    # @param [Hash] params the url params from the current url
    def initialize(query:, filters:, sort_columns: nil, current_user:, params:)
      @results = query
      @current_user = current_user
      @params = params
      @filtering = Filtering.new(filters: filters, search: self)
      defaulting = FilterDefaulting.new(current_user: current_user, search: self)
      defaulting.apply_defaults
      @sorting = Sorting.new(sort_columns: sort_columns, search: self)
    end

    def results
      retrieve_results
    end

    def valid?
      @filtering.validate_params
    end

    def errors
      @filtering.errors
    end

    def error_messages
      errors.join(',')
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

    def sort_clause
      @sorting.sort_clause
    end

    def search_params?
      params.has_key? :search
    end

    def search_params
      search_params? ? params.require(:search).permit(permitted_searchable_columns) : {}
    end

    def blank?(column)
      val = selected_value(column)
      val.is_a?(Array) ? val.all?(&:blank?) : val.blank?
    end

    def default_value?(column)
      val = selected_value(column)
      filter = @filtering.filter(column)
      val && filter.default_value && val.to_s == filter.default_value.to_s
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

    private

      def retrieve_results
        @results = @filtering.apply_filtering(@results)
        @results = @sorting.apply_sorting(@results)
      end

      def searchable_columns
        filters.map(&:searchable_name)
      end

      def permitted_searchable_columns
        # we need to make sure any params that are an array value ( multiple select ) go to the bottom for permit to work
        columns = filters.sort_by { |f| f.respond_to?(:multiple) && f.multiple ? 1 : 0 }
        columns.map { |f|
          if f.respond_to?(:multiple) && f.multiple
            hash = {}
            hash[f.searchable_name] = []
            hash
          else
            f.searchable_name
          end
        }.flatten
      end
  end
end
