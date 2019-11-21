class Sorts
  attr_reader :sort_columns, :sort_column, :sort_direction

  def initialize(sort_columns:, search:)
    @sort_columns = sort_columns
    @search = search
    return if sort_columns.blank?

    @sort_column = set_sort_column
    @sort_direction = set_sort_direction
  end

  def apply_sorting(results)
    sort_query(results) if sort_column.present? && sort_direction.present?
  end

  private

  def setup_sorting(sort_columns:)
    @sort_columns = sort_columns
    return if sort_columns.blank?

    @sort_column = set_sort_column
    @sort_direction = set_sort_direction
  end

  def sort_query(query)
    query.order(sort_clause)
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
    @search.search_params? ? @search.params.require(:search).permit(:sort, :direction) : {}
  end
end