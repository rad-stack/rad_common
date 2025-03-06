class SystemUsageSearch < RadCommon::Search
  DATE_MODE_OPTIONS = %w[Yearly Monthly Weekly Daily].freeze
  DEFAULT_DATE_MODE = 'Weekly'.freeze

  def initialize(params, current_user)
    super(query: nil, filters: filters_def, params: params, current_user: current_user)
  end

  def title
    "System Usage for #{Company.main.name}"
  end

  def total(item_index)
    usage_data[item_index].sum { |item| item[:value] }
  end

  def usage_data
    @usage_data ||=
      usage_items.map do |item|
        data = []

        date_column_ranges.each do |header|
          case item.class.to_s
          when 'String'
            name = item.titleize.pluralize
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

        data
      end
  end

  def date_column_ranges
    @date_column_ranges ||=
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

  def usage_items
    @usage_items ||= prepare_usage_items.sort_by { |item| item.is_a?(String) ? item : item.first }
  end

  private

    def prepare_usage_items
      RadConfig.system_usage_models!.map { |item|
        case item.class.to_s
        when 'String'
          klass = item.constantize
        when 'Array'
          klass = item.first.constantize
        else
          raise "invalid option: #{item.class}"
        end
        next unless Pundit.policy!(current_user, klass).index?

        item
      }.compact
    end

    def filters_def
      [{ input_label: 'Date Mode',
         column: :date_mode,
         options: DATE_MODE_OPTIONS,
         include_blank: false,
         default_value: DEFAULT_DATE_MODE },
       { input_label: 'Number of Columns',
         column: :date_range_count,
         options: (1..24),
         include_blank: false,
         default_value: '6' }]
    end

    def date_range_count
      return 6 if params.dig(:search, :date_range_count).blank?

      params.dig(:search, :date_range_count).to_i
    end

    def date_mode
      params.dig(:search, :date_mode) || DEFAULT_DATE_MODE
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

    def today
      Time.current
    end
end
