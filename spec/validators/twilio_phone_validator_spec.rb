require 'rails_helper'

class TwilioMockModel
  include ActiveModel::Validations
  attr_reader :number, :multiple_numbers, :mobile_phone

  def initialize(number, multiple_numbers = [])
    @number = number
    @multiple_numbers = multiple_numbers
  end

  def number_changed?
    true
  end

  def multiple_numbers_changed?
    true
  end

  validates_with TwilioPhoneValidator, fields: [field: :number]
  validates_with TwilioPhoneValidator, fields: [field: :multiple_numbers], multiples: true
end

RSpec.describe TwilioPhoneValidator, type: :validator do
  let(:mobile_phone) { '(904) 325-2071' }
  let(:standard_phone) { '(904) 503-5030' }
  let(:invalid_phone) { '1234' }

  it 'validates with mobile phone number', :vcr do
    model = TwilioMockModel.new(mobile_phone)
    expect(model.valid?).to eq(true)
  end

  it 'validates a non-mobile phone number', :vcr do
    model = TwilioMockModel.new(standard_phone)
    expect(model.valid?).to eq(true)
  end

  it 'validates with multiple numbers', :vcr do
    model = TwilioMockModel.new(mobile_phone, [mobile_phone, mobile_phone])
    expect(model.valid?).to eq(true)
  end

  it 'invalidates with a non 10 digit number' do
    model = TwilioMockModel.new(invalid_phone)
    expect(model.valid?).to eq(false)
    expect(model.errors.full_messages.first).to eq('Number invalid, format must be (999) 999-9999')
  end

  it 'invalidates without a number' do
    model = TwilioMockModel.new('_')
    expect(model.valid?).to eq(false)
    expect(model.errors.full_messages.first).to eq('Number invalid, format must be (999) 999-9999')
  end

  it 'invalidates with mutliple phone numbers', :vcr do
    model = TwilioMockModel.new(mobile_phone, [mobile_phone, invalid_phone])
    expect(model.valid?).to eq(false)
    expect(model.errors.full_messages.first).to eq('Multiple numbers invalid, format must be (999) 999-9999')
  end
end
