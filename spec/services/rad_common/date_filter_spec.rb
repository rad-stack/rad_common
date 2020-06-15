require 'rails_helper'

RSpec.describe RadCommon::DateFilter, type: :service do
  describe 'datetime_column?' do
    subject(:date_filter) do
      described_class.new(column: :created_at, type: RadCommon::DateFilter).send(:datetime_column?, results)
    end

    let(:results) { Division.all }

    context 'created_at' do
      let(:column) { :created_at }
      it 'detects datetime correctly' do
        expect(subject).to eq true
      end
    end
  end
end