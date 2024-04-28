require 'rails_helper'

class TestPhoneModel
  include ActiveModel::Model
  attr_accessor :running_global_validity, :phone_number, :mobile_phone

  validates_with PhoneNumberValidator, fields: [{ field: :phone_number }, { field: :mobile_phone, type: :mobile }]

  def phone_number_changed?
    true
  end

  def mobile_phone_changed?
    true
  end
end

RSpec.describe PhoneNumberValidator do
  let(:phone_number) { create :phone_number }

  let(:phone_number_stripped) do
    phone_number.delete('(').delete(')').delete('-').delete(' ')
  end
  let(:valid_phone_formats) do
    ['1233211234', '123-321-1234', '123 321 1234', ' 123 321 1234 ', '+11233211234',
     '(123) 321-1234', '123-321-1234', '1-123-321-1234',
     '21233211234', '+1 (123) 321-1234', '(123)321-1234', '1.123.321.1234', '123.321.1234']
  end
  let(:invalid_phone_formats) do
    ['1234', '123-321-1234 ext 5', '(800) 748-2030 ext. 2326 or (800) 550-8582', 'not_a_number']
  end

  it 'formats phone numbers before validating' do
    valid_phone_formats.each do |phone_number|
      model = TestPhoneModel.new
      model.phone_number = phone_number

      expect(model).to be_valid
      expect(model.phone_number).to eq '(123) 321-1234'
    end
  end

  it 'can not be valid' do
    invalid_phone_formats.each do |phone_number|
      model = TestPhoneModel.new
      model.phone_number = phone_number
      expect(model).not_to be_valid
      expect(model.errors.full_messages.to_s).to include 'number invalid, format must be'
    end
  end

  it 'can be valid' do
    model = TestPhoneModel.new
    model.phone_number = phone_number
    expect(model).to be_valid
  end

  it 'converts a 10 digit number to a valid format' do
    model = TestPhoneModel.new
    model.phone_number = phone_number_stripped
    expect(model).to be_valid
    expect(model.phone_number).to eq(phone_number)
  end

  describe 'twilio', :vcr do
    let(:mobile_phone) { create :phone_number, :mobile }

    before do
      allow(RadConfig).to receive(:twilio_enabled?).and_return true

      allow(RadConfig).to receive(:twilio_phone_number!)
        .and_return RadConfig.secret_config_item!(:twilio_alt_phone_number)

      allow(RadConfig).to receive(:twilio_account_sid!)
        .and_return RadConfig.secret_config_item!(:twilio_alt_account_sid)

      allow(RadConfig).to receive(:twilio_auth_token!)
        .and_return RadConfig.secret_config_item!(:twilio_alt_auth_token)
    end

    it 'validates with mobile phone number' do
      model = TestPhoneModel.new
      model.mobile_phone = mobile_phone
      expect(model.valid?).to be(true)
    end

    it 'validates a non-mobile phone number' do
      model = TestPhoneModel.new
      model.phone_number = phone_number
      expect(model.valid?).to be(true)
    end

    it 'invalidates mobile number with a non-mobile number' do
      model = TestPhoneModel.new
      model.mobile_phone = phone_number
      expect(model.valid?).to be(false)
      expect(model.errors.full_messages.first).to eq('Mobile phone does not appear to be a valid mobile phone number')
    end
  end
end
