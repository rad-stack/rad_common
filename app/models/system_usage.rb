class SystemUsage
  attr_accessor :params, :current_user, :usage_items, :usage_data

  def initialize(params, current_user)
    @params = params
    @current_user = current_user

    calc_usage_items
    calc_usage_stats
  end

  def total(item_index)
    usage_data[item_index].sum { |item| item[:value] }
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
    (0..date_range_count - 1).to_a.reverse.map do |item|
      case date_mode
      when 'Yearly'
        yearly_hash item
      when 'Monthly'
        monthly_hash item
      when 'Weekly'
        weekly_hash item
      when 'Daily'
        daily_hash item
      else
        raise 'invalid mode'
      end
    end
  end

  private

    def calc_usage_items
      @usage_items = []

      RadicalConfig.system_usage_models!.each do |item|
        case item.class.to_s
        when 'String'
          klass = item.constantize
        when 'Array'
          klass = item.first.constantize
        else
          raise "invalid option: #{item.class}"
        end

        @usage_items.push(item) if Pundit.policy!(current_user, klass).index?
      end
    end

    def calc_usage_stats
      @usage_data = []

      @usage_items.each do |item|
        data = []

        date_column_ranges.each do |header|
          case item.class.to_s
          when 'String'
            name = item.pluralize
            klass = item.constantize
            result = Pundit.policy_scope!(current_user, klass)
          when 'Array'
            name = item.last
            klass = item.first.constantize
            result = Pundit.policy_scope!(current_user, klass.send(item[1].to_sym))
          else
            raise "invalid option: #{item.class}"
          end

          data.push(name: name, value: result.where(created_at: header[:start]..header[:end]).count)
        end

        @usage_data.push(data)
      end
    end

    def today
      Time.current
    end

    def yearly_hash(item)
      { start: today.advance(years: -item).beginning_of_year.beginning_of_day,
        end: today.advance(years: -item).end_of_year.end_of_day,
        label: today.advance(years: -item).beginning_of_year.strftime('%Y') }
    end

    def monthly_hash(item)
      { start: today.advance(months: -item).beginning_of_month.beginning_of_day,
        end: today.advance(months: -item).end_of_month.end_of_day,
        label: today.advance(months: -item).beginning_of_month.strftime('%B, %Y') }
    end

    def weekly_hash(item)
      { start: today.advance(weeks: -item).beginning_of_week(:sunday).beginning_of_day,
        end: today.advance(weeks: -item).end_of_week(:sunday).end_of_day,
        label: ApplicationController.helpers.format_date(today.advance(weeks: -item).beginning_of_week(:sunday)) }
    end

    def daily_hash(item)
      { start: today.advance(days: -item).beginning_of_day,
        end: today.advance(days: -item).end_of_day,
        label: ApplicationController.helpers.format_date(today.advance(days: -item).beginning_of_day) }
    end
end
