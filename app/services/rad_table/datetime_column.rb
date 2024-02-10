module RadTable
  class DatetimeColumn < Column
    def format_value(value)
      datetime = view_context.format_datetime(value)
      if options[:show_distance]
        "#{datetime} (#{view_context.distance_of_time_in_words_to_now(value)} ago)"
      else
        datetime
      end
    end
  end
end
