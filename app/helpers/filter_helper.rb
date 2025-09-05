module FilterHelper
  def filter_col_class(filter)
    return 'normal' unless filter.respond_to?(:col_class)

    filter.col_class
  end
end
