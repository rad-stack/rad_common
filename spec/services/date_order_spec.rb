require 'rails_helper'

RSpec.describe DateOrder, type: :service do
  describe 'invalid_date_order' do
    context 'nil dates' do
      it 'is false' do
        expect(described_class.invalid_date_order?(nil, nil)).to eq(false)
        expect(described_class.invalid_date_order?(nil, Date.current)).to eq(false)
        expect(described_class.invalid_date_order?(Date.current, nil)).to eq(false)
      end
    end

    context 'start date before end date' do
      let(:start_date) { Date.current }
      let(:end_date) { Date.current + 1.day }
      it 'is false' do
        expect(described_class.invalid_date_order?(start_date, end_date)).to eq(false)
      end
    end

    context 'start date after end date' do
      let(:start_date) { Date.current + 1.day }
      let(:end_date) { Date.current }
      it 'is true' do
        expect(described_class.invalid_date_order?(start_date, end_date)).to eq(true)
      end
    end
  end
end
