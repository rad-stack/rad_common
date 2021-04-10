class SystemUsage
  attr_accessor :params, :current_user, :usage_items, :usage_data

  def initialize(params, current_user)
    @params = params
    @current_user = current_user

    calc_usage_stats
  end

  def date_mode
    params[:date_mode] || 'Weekly'
  end

  def date_range_count
    return 6 if params[:date_range_count].blank?

    params[:date_range_count].to_i
  end

  def title
    "System Usage for #{Company.main.name}"
  end

  def self.date_mode_options
    %w[Yearly Monthly Weekly Daily]
  end

  def self.date_range_count_options
    (1..24)
  end

  def date_column_ranges
    today = Time.current

    (0..date_range_count - 1).to_a.reverse.map do |item|
      case date_mode
      when 'Yearly'
        { start: today.advance(years: -item).beginning_of_year.beginning_of_day,
          end: today.advance(years: -item).end_of_year.end_of_day,
          label: today.advance(years: -item).beginning_of_year.strftime('%Y') }
      when 'Monthly'
        { start: today.advance(months: -item).beginning_of_month.beginning_of_day,
          end: today.advance(months: -item).end_of_month.end_of_day,
          label: today.advance(months: -item).beginning_of_month.strftime('%B, %Y') }
      when 'Weekly'
        { start: today.advance(weeks: -item).beginning_of_week(:sunday).beginning_of_day,
          end: today.advance(weeks: -item).end_of_week(:sunday).end_of_day,
          label: ApplicationController.helpers.format_date(today.advance(weeks: -item).beginning_of_week(:sunday)) }
      when 'Daily'
        { start: today.advance(days: -item).beginning_of_day,
          end: today.advance(days: -item).end_of_day,
          label: ApplicationController.helpers.format_date(today.advance(days: -item).beginning_of_day) }
      else
        raise 'invalid mode'
      end
    end
  end

  private

    def calc_usage_stats
      @usage_items = RadCommon.system_usage_models
      @usage_data = []

      @usage_items.each do |item|
        data = []

        date_column_ranges.each do |header|
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

        @usage_data.push(data)
      end
    end
end
