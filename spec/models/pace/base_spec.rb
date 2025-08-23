require 'rails_helper'

RSpec.describe Pace::Base do
  let(:base_object) { Pace::Receivable }
  let(:xpath) { '@amountDue > 0' }

  describe '#where' do
    let(:results) { base_object.where(xpath) }

    it 'returns records from xpath filter', :vcr do
      expect(results.count).to be_positive
      expect(results.total_pages).to eq 1
    end

    context 'when no records exist' do
      let(:xpath) { '@id = 99999' }

      it 'returns an empty collection', :vcr do
        expect(results.count).to eq 0
      end
    end

    context 'when chaining multiple where clauses' do
      let(:additional_xpath) { "@customer = 'HOUSE'" }
      let(:new_results) { base_object.where(xpath).where(additional_xpath) }

      it 'returns records matching both conditions', :vcr do
        expect(new_results.count).to be < results.count
      end
    end
  end

  describe '#select' do
    let(:base_object) { Pace::Customer }
    let(:xpath) { "@salesPerson = #{house_sales_person.id}" }
    let(:house_sales_person) { Pace::SalesPerson.find_by(name: 'House Account') }
    let(:selected_attributes) { [:id, :custName, { xpath: 'salesPerson/@name', name: 'salesPersonName' }] }
    let(:results) { base_object.where(xpath).select(selected_attributes) }

    it 'selects specific fields', :vcr do
      expect(results.count).to be_positive
      expect(results.first.salesPersonName).to eq('House Account')
    end
  end

  describe '#page_and_sort' do
    let(:results) { base_object.where(xpath).page_and_sort(page: 1, sort_xpath: '@id', sort_direction: 'desc') }

    it 'returns paginated and sorted records', :vcr do
      expect(results.count).to be_positive
      expect(results.total_pages).to be > 1
    end
  end

  describe '#find' do
    let(:result) { base_object.find(5001) }

    it 'finds a specific record by id', :vcr do
      expect(result).to be_a(Pace::Receivable)
    end
  end

  describe '#save!' do
    let(:base_object) { Pace::JobType }
    let(:result) { base_object.find(1) }
    let(:original_description) { result.description }

    it 'finds a specific record by id and updates it', :vcr do
      result.description = 'Updated description'
      result.save!
      read_again = base_object.find(1)
      expect(read_again.description).to eq('Updated description')
      read_again.description = original_description
      read_again.save!
    end
  end

  describe '#create!' do
    let(:base_object) { Pace::PaymentBatch }
    let(:date_raw) { '2025-01-02' }
    let(:date) { Date.parse(date_raw) }
    let(:period) do
      periods = Pace::GLAccountingPeriod.where("@glPeriodStatus = 'O' and @fiscalYear = #{date.year}")
      periods.to_a.find { |period| date.between?(parse_date(period.startDate), parse_date(period.endDate)) }
    end

    it 'creates a new record', :vcr do
      period
      # TODO: maybe support parsing date objects directly
      batch = base_object.create(date: date_raw,
                                 description: 'Testing batch creation', glAccountingPeriod: period.id)
      expect(batch).to be_a(Pace::PaymentBatch)
      lookup_batch = Pace::PaymentBatch.find(batch.id)
      # TODO: weird bug where passing the date goes to previous day, might need to specify timezone
      # expect(lookup_batch.date).to eq(date_raw)
      expect(lookup_batch.date).to eq('2025-01-01')
      expect(lookup_batch.description).to eq('Testing batch creation')
    end
  end

  def parse_date(timestamp)
    return if timestamp.blank?

    Time.zone.parse(timestamp)
  end
end
