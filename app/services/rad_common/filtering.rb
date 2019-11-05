module RadCommon
  module Filtering
    include FilterDefaulting
    attr_reader :filters

    def setup_filtering(filters:)
      @filters = build_search_filters(filters)
      @filter_hash =  Hash[@filters.collect { |f| [f.searchable_name, f] }]

      setup_filter_defaults
    end

    def search_params
      search_params? ? params.require(:search).permit(permitted_searchable_columns) : {}
    end

    def searchable_columns_strings
      searchable_columns.map(&:to_s)
    end

    def permitted_searchable_columns
      # we need to make sure any params that are an array value ( multiple select ) go to the bottom for permit to work
      columns = @filters.sort_by { |f| f.multiple ? 1 : 0 }
      columns.map do |f|
        if f.multiple
          hash = {}
          hash[f.searchable_name] = []
          hash
        else
          f.searchable_name
        end
      end
    end

    def searchable_columns
      filters.map(&:searchable_name)
    end

    def selected_value(column)
      search_params[column]
    end

    private

    def search_params?
      params.has_key? :search
    end

    def apply_filtering
      apply_joins
      apply_filters
    end

    def apply_filters
      search_params.each do |key, value|
        filter = @filter_hash[key.to_sym]
        @results = filter.apply_filter(@results, value) || @results
      end
    end

    def apply_joins
      @results = @results.joins(joins)
    end

    def build_search_filters(filters)
      filters.map { |filter| SearchFilter.new(filter) }
    end

    def joins
      filters.map(&:joins).compact
    end
  end
end