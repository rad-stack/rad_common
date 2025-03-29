require 'rails_helper'

RSpec.describe PhoneNumberFormatter, type: :service do
  describe 'format' do
    it 'formats phone numbers correctly' do
      expect(described_class.format('(999)999-9999')).to eq '(999) 999-9999'
      expect(described_class.format('999999-9999')).to eq '(999) 999-9999'
      expect(described_class.format('9999999999')).to eq '(999) 999-9999'
      expect(described_class.format(9_999_999_999)).to eq '(999) 999-9999'
      expect(described_class.format('999-999-9999')).to eq '(999) 999-9999'
    end
  end
end
