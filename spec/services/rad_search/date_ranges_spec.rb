require 'rails_helper'

RSpec.describe RadSearch::DateRanges, type: :service do
  describe '#ranges_for_group' do
    it 'returns current/previous ranges' do
      current_ranges = described_class.ranges_for_group(:current)
      expect(current_ranges.keys).to contain_exactly('today', 'this_week', 'this_month', 'this_year')

      previous_ranges = described_class.ranges_for_group(:previous)
      expect(previous_ranges.keys).to contain_exactly('yesterday', 'last_week', 'last_month', 'last_year')
    end
  end

  describe '#valid_range?' do
    it 'returns true for valid ranges and false for invalid ranges' do
      expect(described_class.valid_range?('today')).to be true
      expect(described_class.valid_range?('this_month')).to be true

      expect(described_class.valid_range?('invalid')).to be false
      expect(described_class.valid_range?(nil)).to be false
    end
  end

  describe '#calculate_range' do
    context 'with today' do
      it 'returns current date for both start and end' do
        start_date, end_date = described_class.calculate_range('today')
        expect(start_date).to eq(Date.current)
        expect(end_date).to eq(Date.current)
      end
    end

    context 'with this_week' do
      it 'returns current week range' do
        start_date, end_date = described_class.calculate_range('this_week')
        expect(start_date).to eq(Date.current.beginning_of_week)
        expect(end_date).to eq(Date.current.end_of_week)
      end
    end

    context 'with this_month' do
      it 'returns current month range' do
        Timecop.travel(Date.new(2025, 6, 15)) do
          start_date, end_date = described_class.calculate_range('this_month')
          expect(start_date).to eq(Date.new(2025, 6, 1))
          expect(end_date).to eq(Date.new(2025, 6, 30))
        end
      end
    end

    context 'with this_year' do
      it 'returns current year range' do
        start_date, end_date = described_class.calculate_range('this_year')
        expect(start_date).to eq(Date.current.beginning_of_year)
        expect(end_date).to eq(Date.current.end_of_year)
      end
    end

    context 'with yesterday' do
      it 'returns yesterday for both start and end' do
        start_date, end_date = described_class.calculate_range('yesterday')
        yesterday = Date.current - 1.day
        expect(start_date).to eq(yesterday)
        expect(end_date).to eq(yesterday)
      end
    end

    context 'with last_week' do
      it 'returns last week range' do
        start_date, end_date = described_class.calculate_range('last_week')
        expect(start_date).to eq((Date.current - 1.week).beginning_of_week)
        expect(end_date).to eq((Date.current - 1.week).end_of_week)
      end
    end

    context 'with last_month' do
      it 'returns last month range' do
        start_date, end_date = described_class.calculate_range('last_month')
        expect(start_date).to eq((Date.current - 1.month).beginning_of_month)
        expect(end_date).to eq((Date.current - 1.month).end_of_month)
      end
    end

    context 'with last_year' do
      it 'returns last year range' do
        start_date, end_date = described_class.calculate_range('last_year')
        expect(start_date).to eq((Date.current - 1.year).beginning_of_year)
        expect(end_date).to eq((Date.current - 1.year).end_of_year)
      end
    end

    context 'with invalid range' do
      it 'returns nil' do
        expect(described_class.calculate_range('invalid')).to be_nil
      end
    end
  end

  describe '#as_json' do
    it 'returns JSON with calculated dates' do
      json_string = described_class.as_json
      parsed = JSON.parse(json_string)

      expect(parsed).to be_a(Hash)
      expect(parsed['today']).to include('startDate', 'endDate')
      expect(parsed['today']['startDate']).to eq(Date.current.strftime('%Y-%m-%d'))
      expect(parsed['this_month']['startDate']).to eq(Date.current.beginning_of_month.strftime('%Y-%m-%d'))
      expect(parsed['this_month']['endDate']).to eq(Date.current.end_of_month.strftime('%Y-%m-%d'))
    end
  end
end
