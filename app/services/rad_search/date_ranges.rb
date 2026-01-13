module RadSearch
  class DateRanges
    RANGES = {
      'today' => {
        label: 'Today',
        group: :current,
        calculate: -> { [Date.current, Date.current] }
      },
      'this_week' => {
        label: 'This Week',
        group: :current,
        calculate: -> { [Date.current.beginning_of_week, Date.current.end_of_week] }
      },
      'this_month' => {
        label: 'This Month',
        group: :current,
        calculate: -> { [Date.current.beginning_of_month, Date.current.end_of_month] }
      },
      'this_year' => {
        label: 'This Year',
        group: :current,
        calculate: -> { [Date.current.beginning_of_year, Date.current.end_of_year] }
      },
      'yesterday' => {
        label: 'Yesterday',
        group: :previous,
        calculate: -> { [Date.current - 1.day, Date.current - 1.day] }
      },
      'last_week' => {
        label: 'Last Week',
        group: :previous,
        calculate: -> { [(Date.current - 1.week).beginning_of_week, (Date.current - 1.week).end_of_week] }
      },
      'last_month' => {
        label: 'Last Month',
        group: :previous,
        calculate: -> { [(Date.current - 1.month).beginning_of_month, (Date.current - 1.month).end_of_month] }
      },
      'last_year' => {
        label: 'Last Year',
        group: :previous,
        calculate: -> { [(Date.current - 1.year).beginning_of_year, (Date.current - 1.year).end_of_year] }
      }
    }.freeze

    class << self
      # Safe accessor methods for each range (returns the range key string)
      def today
        'today'
      end

      def this_week
        'this_week'
      end

      def this_month
        'this_month'
      end

      def this_year
        'this_year'
      end

      def yesterday
        'yesterday'
      end

      def last_week
        'last_week'
      end

      def last_month
        'last_month'
      end

      def last_year
        'last_year'
      end

      def all_range_keys
        RANGES.keys
      end

      def ranges_for_group(group)
        RANGES.select { |_key, config| config[:group] == group }
      end

      def valid_range?(range_key)
        RANGES.key?(range_key)
      end

      def calculate_range(range_key)
        return nil unless valid_range?(range_key)

        RANGES[range_key][:calculate].call
      end

      def label_for(range_key)
        RANGES.dig(range_key, :label)
      end

      def all_with_dates
        RANGES.transform_values do |config|
          start_date, end_date = config[:calculate].call
          {
            label: config[:label],
            group: config[:group],
            start_date: start_date,
            end_date: end_date
          }
        end
      end

      def as_json
        RANGES.transform_values { |config|
          start_date, end_date = config[:calculate].call
          {
            'startDate' => start_date.strftime('%Y-%m-%d'),
            'endDate' => end_date.strftime('%Y-%m-%d')
          }
        }.to_json
      end
    end
  end
end
