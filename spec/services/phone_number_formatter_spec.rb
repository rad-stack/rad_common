require 'rails_helper'

RSpec.describe PhoneNumberFormatter, type: :service do
  let(:valid_phone_formats) do
    ['1233211234', '123-321-1234', '123 321 1234', ' 123 321 1234 ', '+11233211234',
     '(123) 321-1234', '123-321-1234', '1-123-321-1234',
     '21233211234', '+1 (123) 321-1234', '(123)321-1234']
  end

  describe 'format' do
    it 'formats phone numbers correctly' do
      valid_phone_formats.each do |phone_number|
        expect(described_class.format(phone_number)).to eq '(123) 321-1234'
      end
    end
  end
end
