require 'rails_helper'

RSpec.describe RadReports::ValueFormatter, type: :service do
  describe '.format_record_value' do
    subject(:formatted_value) { described_class.format_record_value(record, column_def) }

    let(:user) { create :user, first_name: 'John', last_name: 'Doe' }
    let(:column_def) { nil }

    context 'with simple column select' do
      let(:record) { user }
      let(:column_def) { { select: 'first_name' } }

      it 'returns column value' do
        expect(formatted_value).to eq 'John'
      end
    end

    context 'with joined column select' do
      let(:column_def) { { select: 'owner.email' } }
      let(:record) { double('record', owner_email: 'test@example.com') }

      it 'extracts value using underscore notation' do
        expect(formatted_value).to eq 'test@example.com'
      end
    end

    context 'with attachment column' do
      let(:record) { user }
      let(:column_def) { { name: 'avatar', is_attachment: true } }

      it 'calls format_attachment_value' do
        expect(formatted_value).to be_nil
      end
    end

    context 'with formula column' do
      let(:record) { user }
      let(:column_def) do
        {
          name: 'first_name',
          formula: [{ 'type' => 'upcase', 'params' => {} }],
          select: 'first_name'
        }
      end

      it 'processes value through formula' do
        allow(RadReports::FormulaProcessor).to receive(:call)
          .with(column_def[:formula], 'John', record)
          .and_return('JOHN')

        expect(formatted_value).to eq 'JOHN'
      end
    end

    context 'with nil value' do
      let(:record) { user }
      let(:column_def) { { select: 'nonexistent_column' } }

      it 'returns nil' do
        expect(formatted_value).to be_nil
      end
    end
  end

  describe '.extract_value' do
    subject(:extracted_value) { described_class.extract_value(record, column_def) }

    let(:user) { create :user, first_name: 'Jane' }
    let(:column_def) { nil }

    context 'with simple attribute access' do
      let(:record) { user }
      let(:column_def) { { select: 'first_name' } }

      it 'returns value via public_send' do
        expect(extracted_value).to eq 'Jane'
      end
    end

    context 'with joined column notation' do
      let(:column_def) { { name: 'email', select: 'owner.email' } }
      let(:record) { double('record') }

      it 'tries underscore notation first' do
        allow(record).to receive(:respond_to?).with('owner_email').and_return(true)
        allow(record).to receive(:owner_email).and_return('test@example.com')

        expect(extracted_value).to eq 'test@example.com'
      end

      it 'falls back to column name if underscore notation fails' do
        fallback_record = double('record')
        allow(fallback_record).to receive(:respond_to?).with('owner_email').and_return(false)
        allow(fallback_record).to receive(:respond_to?).with('email').and_return(true)
        allow(fallback_record).to receive(:[]).with(nil).and_return(nil)
        allow(fallback_record).to receive(:[]).with('owner_email').and_return(nil)
        allow(fallback_record).to receive(:email).and_return('fallback@example.com')

        result = described_class.extract_value(fallback_record, column_def)
        expect(result).to eq 'fallback@example.com'
      end
    end

    context 'with hash-like record access' do
      let(:record) { { 'name' => 'Test Value' } }
      let(:column_def) { { select: 'name' } }

      it 'accesses value via hash key' do
        expect(extracted_value).to eq 'Test Value'
      end
    end

    context 'with string hash key' do
      let(:record) { { 'name' => 'String Key' } }
      let(:column_def) { { select: 'name' } }

      it 'accesses via string key' do
        expect(extracted_value).to eq 'String Key'
      end
    end

    context 'with missing column' do
      let(:record) { user }
      let(:column_def) { { select: 'nonexistent' } }

      it 'returns nil' do
        expect(extracted_value).to be_nil
      end
    end

    context 'with deeply nested joined column' do
      let(:column_def) { { select: 'owner.user_status.name' } }
      let(:record) { double('record') }

      it 'converts dots to underscores' do
        allow(record).to receive(:respond_to?).with('owner_user_status_name').and_return(true)
        allow(record).to receive(:owner_user_status_name).and_return('Active')

        expect(extracted_value).to eq 'Active'
      end
    end
  end
end
