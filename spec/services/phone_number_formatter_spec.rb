require 'rails_helper'

RSpec.describe PhoneNumberFormatter, type: :service do
  let(:valid_phone_formats) do
    ['1233211234', '123-321-1234', '123 321 1234', ' 123 321 1234 ', '+11233211234',
     '(123) 321-1234', '123-321-1234', '1-123-321-1234',
     '21233211234', '+1 (123) 321-1234', '(123)321-1234',
     '123.321.1234', '1.123.321.1234']
  end

  let(:invalid_phone_formats) do
    ['foo bar', 'foo bar 1', 'foo bar 1234567890', '123-321-1234 ext 5', '123-321-1234 foo bar']
  end

  describe 'format' do
    it 'formats phone numbers correctly' do
      valid_phone_formats.each do |phone_number|
        expect(described_class.format(phone_number)).to eq '(123) 321-1234'
      end
    end

    it 'ignores non-phone numbers' do
      invalid_phone_formats.each do |phone_number|
        expect(described_class.format(phone_number)).to be_nil
      end
    end
  end
end
