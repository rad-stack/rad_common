module RadCommon
  class Filtering
    attr_reader :filters

    def initialize(filters:, search: search)
      @search = search
      @current_user = search.current_user
      @filters = build_search_filters(filters)
      @filter_hash = Hash[@filters.collect { |f| [f.searchable_name, f] }]
    end

    def apply_filtering(results)
      results = results.authorized(@current_user)
      results = apply_joins(results)
      apply_filters(results)
    end

    private

      def apply_filters(results)
        @filters.each do |filter|
          applied_results = filter.apply_filter(results, @search.search_params)
          results = applied_results || results
        end

        results
      end

      def apply_joins(results)
        results.joins(joins)
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
  end
end