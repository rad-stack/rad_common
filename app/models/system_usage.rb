class SystemUsage
  def self.usage_stats(mode)
    today = Time.current

    usage_headers = (0..5).to_a.reverse.map do |item|
      case mode
      when 'yearly'
        { start: today.advance(years: -item).beginning_of_year.beginning_of_day,
          end: today.advance(years: -item).end_of_year.end_of_day,
          label: today.advance(years: -item).beginning_of_year.strftime('%Y') }
      when 'monthly'
        { start: today.advance(months: -item).beginning_of_month.beginning_of_day,
          end: today.advance(months: -item).end_of_month.end_of_day,
          label: today.advance(months: -item).beginning_of_month.strftime('%B, %Y') }
      when 'weekly'
        { start: today.advance(weeks: -item).beginning_of_week.beginning_of_day,
          end: today.advance(weeks: -item).end_of_week.end_of_day,
          label: ApplicationController.helpers.format_date(today.advance(weeks: -item).beginning_of_week) }
      when 'daily'
        { start: today.advance(days: -item).beginning_of_day,
          end: today.advance(days: -item).end_of_day,
          label: ApplicationController.helpers.format_date(today.advance(days: -item).beginning_of_day) }
      else
        raise 'invalid mode'
      end
    end

    usage_items = RadCommon.system_usage_models
    usage_data = []

    usage_items.each do |item|
      data = []

      usage_headers.each do |header|
        case item.class.to_s
        when 'String'
          name = item.pluralize
          result = item.constantize.unscoped
        when 'Array'
          name = item.last
          result = item.first.constantize.send(item[1].to_sym)
        else
          raise "invalid option: #{item.class}"
        end

        data.push(name: name, value: result.where(created_at: header[:start]..header[:end]).count)
      end

      usage_data.push(data)
    end

    [usage_headers, usage_items, usage_data]
  end
end
