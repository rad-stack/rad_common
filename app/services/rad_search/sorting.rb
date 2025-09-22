module RadSearch
  class Sorting
    NULLS_LAST = ' NULLS LAST'.freeze

    attr_reader :sort_columns, :sort_column, :sort_direction

    # @param [Array] sort_columns An array of sort columns
    # @option sort_columns [String] :label The label displayed on column header
    # @option sort_columns [String] :column The column to sort on.
    # @option sort_columns [String optional] :direction The direction of the sort either asc or desc
    # @option sort_columns [Boolean optional] :default When true this makes this sort the default sort for the query
    # @example
    #   [{label: 'Order', column: 'orders.order_number'},
    #    {label: 'Due Date', column: 'orders.due_date', default: true, direction: 'asc'},
    #    {label: 'Name', column: 'users.first_name, users.last_name'}]
    def initialize(sort_columns:, search:)
      @sort_columns = sort_columns
      @search = search
      return if sort_columns.blank?

      @sort_column = set_sort_column
      @sort_direction = set_sort_direction
    end

    def apply_sorting(results)
      if sort_column.present? && sort_direction.present?
        sort_query(results)
      else
        results
      end
    end

    def sort_clause(record_class)
      @sort_column.split(',').map { |item|
        "#{item.strip} #{@sort_direction}#{nulls_last(item, record_class)}"
      }.join(', ')
    end

    private

      def setup_sorting(sort_columns:)
        @sort_columns = sort_columns
        return if sort_columns.blank?

        @sort_column = set_sort_column
        @sort_direction = set_sort_direction
      end

      def sort_query(query)
        query.order(sort_clause(query.klass))
      end

      def set_sort_column
        @sort_column = sort_params[:sort].presence || find_sort_config[:column]
      end

      def set_sort_direction
        @sort_direction = sort_params[:direction].presence || find_sort_config[:direction].presence || 'asc'
      end

      def find_sort_config
        if sort_params[:sort].present?
          sort_columns.detect { |item| item[:column] == sort_params[:sort] }
        else
          default_column = sort_columns.detect { |item| item[:default] }
          default_column || sort_columns.first
        end
      end

      def sort_params
        return {} unless @search.search_params?

        @search.params.require(:search).slice(:sort, :direction).permit(:sort, :direction)
      end

      def nulls_last(item, record_class)
        return NULLS_LAST unless record_class.respond_to?(:columns_hash)

        column = record_class.columns_hash[item]
        column.present? && !column.null ? '' : NULLS_LAST
      end
  end
end
