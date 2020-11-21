require 'rails_helper'

RSpec.describe RadCommon::DateFilter, type: :service do
  describe 'datetime_column?' do
    subject(:date_filter) do
      described_class.new(column: column, type: described_class).send(:datetime_column?, results)
    end

    let(:results) { Division.all }

    context 'with created_at' do
      let(:column) { :created_at }

      it 'detects datetime correctly' do
        expect(date_filter).to eq true
      end
    end

    context 'with date_established' do
      let(:column) { :date_established }

      it 'detects datetime correctly' do
        expect(date_filter).to eq false
      end
    end
  end
end
