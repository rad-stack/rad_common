require 'rails_helper'

describe SystemUsage, type: :model do
  let(:user) { create :admin }
  let(:params) { { date_mode: 'Weekly', date_range_count: 4 } }
  let(:system_usage) { described_class.new(params, user) }

  describe 'date_column_ranges' do
    subject(:date_ranges) { system_usage.date_column_ranges.pluck(:start) }

    let(:day) { Time.current.beginning_of_week(:sunday).beginning_of_day }
    let(:expected_dates) do
      [day - 3.weeks,
       day - 2.weeks,
       day - 1.week,
       day]
    end

    before do
      Timecop.freeze(Time.current.beginning_of_week)
    end

    it 'returns list of weekly date ranges' do
      expect(date_ranges).to eq(expected_dates)
    end
  end
end
