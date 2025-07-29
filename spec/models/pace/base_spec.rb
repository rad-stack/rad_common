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
end
