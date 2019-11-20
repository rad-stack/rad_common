module RadCommon
  module Filtering
    include FilterDefaulting
    attr_reader :filters

    def search_params
      search_params? ? params.require(:search).permit(permitted_searchable_columns) : {}
    end

    def blank?(column)
      val = selected_value(column)
      val.is_a?(Array) ? val.all?(&:blank?) : val.blank?
    end

    def selected_value(column)
      search_params[column]
    end

    private

      def setup_filtering(filters:)
        @filters = build_search_filters(filters)
        @filter_hash = Hash[@filters.collect { |f| [f.searchable_name, f] }]

        setup_filter_defaults
      end

      def apply_filtering
        @results = @results.authorized(current_user)
        apply_joins
        apply_filters
      end

      def apply_filters
        @filters.each do |filter|
          results = filter.apply_filter(@results, search_params)
          @results = results || @results
        end
      end

      def apply_joins
        @results = @results.joins(joins)
      end

      def build_search_filters(filters)
        filters.map do |filter|
          if filter.has_key? :type
            filter[:type].send(:new, filter)
          else
            SearchFilter.new(filter)
          end
        end
      end

      def joins
        filters.select { |f| f.respond_to? :joins }.map(&:joins).compact
      end

      def searchable_columns
        filters.map(&:searchable_name)
      end

      def searchable_columns_strings
        searchable_columns.map(&:to_s)
      end

      def permitted_searchable_columns
        # we need to make sure any params that are an array value ( multiple select ) go to the bottom for permit to work
        columns = @filters.sort_by { |f| f.respond_to(:multiple) && f.multiple ? 1 : 0 }
        columns.map { |f|
          if f.respond_to(:multiple) && f.multiple
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
