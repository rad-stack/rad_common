require 'rails_helper'

describe SystemUsageSearch, type: :service do
  let(:user) { create :admin }
  let(:params) { { search: { date_mode: 'Weekly', date_range_count: 4 } } }
  let(:system_usage) { described_class.new(params, user) }

  describe 'date_column_ranges' do
    subject(:date_ranges) { system_usage.date_column_ranges.map { |range| [range[:start], range[:end]] } }

    let(:first_day_of_week) { Time.current.beginning_of_week(:sunday).beginning_of_day }
    let(:last_day_of_week) { Time.current.end_of_week(:sunday).end_of_day }

    let(:expected_date_ranges) do
      [[first_day_of_week - 3.weeks, last_day_of_week - 3.weeks],
       [first_day_of_week - 2.weeks, last_day_of_week - 2.weeks],
       [first_day_of_week - 1.week, last_day_of_week - 1.week],
       [first_day_of_week, last_day_of_week]]
    end

    it 'returns list of weekly date ranges' do
      Timecop.freeze(Time.current.beginning_of_week) { expect(date_ranges).to eq(expected_date_ranges) }
    end
  end
end
