require 'rails_helper'

RSpec.describe PhoneNumberFormatter, type: :service do
  describe 'format' do
    it 'formats phone numbers correctly' do
      expect(described_class.format('(123)321-1234')).to eq '(123) 321-1234'
      expect(described_class.format('123321-1234')).to eq '(123) 321-1234'
      expect(described_class.format('1233211234')).to eq '(123) 321-1234'
      expect(described_class.format(1_233_211_234)).to eq '(123) 321-1234'
      expect(described_class.format('123-321-1234')).to eq '(123) 321-1234'
    end
  end
end
