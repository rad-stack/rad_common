require 'rails_helper'

RSpec.describe RadReports::CalculatedColumnProcessor, type: :service do
  describe '.extract_column_value' do
    let(:user) { create :user, first_name: 'John', last_name: 'Doe' }
    let(:record_with_data) { { 'users_first_name' => 'Jane', 'users_last_name' => 'Smith' } }

    context 'with direct column access' do
      it 'returns value from record method' do
        value = described_class.extract_column_value(user, 'first_name')
        expect(value).to eq('John')
      end
    end

    context 'with aliased column access' do
      it 'returns value from hash-like record' do
        value = described_class.extract_column_value(record_with_data, 'users.first_name')
        expect(value).to eq('Jane')
      end

      it 'returns value with direct alias' do
        value = described_class.extract_column_value(record_with_data, 'users_first_name')
        expect(value).to eq('Jane')
      end
    end

    context 'with non-existent column' do
      it 'returns nil' do
        value = described_class.extract_column_value(user, 'non_existent_column')
        expect(value).to be_nil
      end
    end

    context 'with blank inputs' do
      it 'returns nil for blank column path' do
        value = described_class.extract_column_value(user, '')
        expect(value).to be_nil
      end

      it 'returns nil for nil record' do
        value = described_class.extract_column_value(nil, 'first_name')
        expect(value).to be_nil
      end
    end
  end
end
