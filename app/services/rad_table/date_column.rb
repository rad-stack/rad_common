module RadTable
  class DateColumn < Column
    def format_value(value)
      view_context.format_date(value)
    end
  end
end
