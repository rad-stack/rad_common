require 'rails_helper'

class TwilioMockModel
  include ActiveModel::Validations
  attr_accessor :number, :multiple_numbers, :mobile

  def number_changed?
    true
  end

  def mobile_changed?
    true
  end

  def multiple_numbers_changed?
    true
  end

  validates_with TwilioPhoneValidator, fields: [{ field: :number }, { field: :mobile, type: :mobile }]
  validates_with TwilioPhoneValidator, fields: [{ field: :multiple_numbers }], multiples: true
end

RSpec.describe TwilioPhoneValidator, type: :validator do
  let(:mobile_phone) { create :phone_number, :mobile }
  let(:standard_phone) { create :phone_number }
  let(:invalid_phone) { '1234' }

  before { allow(RadicalTwilio).to receive(:twilio_enabled?).and_return(true) }

  it 'validates with mobile phone number', :vcr do
    model = TwilioMockModel.new
    model.mobile = mobile_phone
    expect(model.valid?).to eq(true)
  end

  it 'validates a non-mobile phone number', :vcr do
    model = TwilioMockModel.new
    model.number = standard_phone
    expect(model.valid?).to eq(true)
  end

  it 'invalidates mobile number with a non-mobile number', :vcr do
    model = TwilioMockModel.new
    model.mobile = standard_phone
    expect(model.valid?).to eq(false)
    expect(model.errors.full_messages.first).to eq('Mobile does not appear to be a valid mobile phone number')
  end

  it 'validates with multiple numbers', :vcr do
    model = TwilioMockModel.new
    model.mobile = mobile_phone
    model.multiple_numbers = [mobile_phone, mobile_phone]
    expect(model.valid?).to eq(true)
  end

  it 'invalidates with a non 10 digit number' do
    model = TwilioMockModel.new
    model.number = invalid_phone
    expect(model.valid?).to eq(false)
    expect(model.errors.full_messages.first).to eq('Number invalid, format must be (999) 999-9999')
  end

  it 'invalidates without a number' do
    model = TwilioMockModel.new
    model.number = '_'
    expect(model.valid?).to eq(false)
    expect(model.errors.full_messages.first).to eq('Number invalid, format must be (999) 999-9999')
  end

  it 'invalidates with mutliple phone numbers', :vcr do
    model = TwilioMockModel.new
    model.mobile = mobile_phone
    model.multiple_numbers = [mobile_phone, invalid_phone]
    expect(model.valid?).to eq(false)
    expect(model.errors.full_messages.first).to eq('Multiple numbers invalid, format must be (999) 999-9999')
  end
end
