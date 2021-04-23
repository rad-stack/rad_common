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

  it 'can not be valid' do
    invalid_numbers = %w([232332 1234 -])

    invalid_numbers.each do |phone_number|
      model = TestPhoneModel.new
      model.phone_number = phone_number
      expect(model).to be_invalid
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

  it 'identifies valid but fake numbers' do
    invalid_numbers = ['(999) 999-9999', '(000) 226-1245']

    invalid_numbers.each do |phone_number|
      model = TestPhoneModel.new
      model.phone_number = phone_number
      expect(model).to be_invalid
      expect(model.errors.full_messages.to_s).to include 'number invalid, format must be'
    end
  end

  describe 'twilio', :vcr do
    let(:mobile_phone) { create :phone_number, :mobile }

    before { allow(RadicalTwilio).to receive(:twilio_enabled?).and_return(true) }

    # These tests need to be disabled because only live credentials can be used
    # To run the tests locally, switch the account to live creds in .env.test and run these
    # Do not commit any changes to git

    xit 'validates with mobile phone number' do
      model = TestPhoneModel.new
      model.mobile_phone = mobile_phone
      expect(model.valid?).to eq(true)
    end

    xit 'validates a non-mobile phone number' do
      model = TestPhoneModel.new
      model.phone_number = phone_number
      expect(model.valid?).to eq(true)
    end

    xit 'invalidates mobile number with a non-mobile number' do
      model = TestPhoneModel.new
      model.mobile_phone = phone_number
      expect(model.valid?).to eq(false)
      expect(model.errors.full_messages.first).to eq('Mobile phone does not appear to be a valid mobile phone number')
    end
  end
end
