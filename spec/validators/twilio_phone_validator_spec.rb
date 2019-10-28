require 'rails_helper'

class TwilioMockModel
  include ActiveModel::Validations
  attr_reader :number, :multiple_numbers

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
  let(:mobile_phone) { '9043252071' }
  let(:standard_phone) { '9045035030' }
  let(:invalid_phone) { '1234' }

  it 'validates with mobile phone number', vcr: true do
    model = TwilioMockModel.new(mobile_phone)
    model.valid?
    puts model.errors.full_messages.to_s
    expect(model.valid?).to eq(true)
  end

  it 'validates a non-mobile phone number', vcr: true, regression: true do
    model = TwilioMockModel.new(standard_phone)
    expect(model.valid?).to eq(true)
  end

  it 'validates with multiple numbers', vcr: true do
    model = TwilioMockModel.new(mobile_phone, [mobile_phone, mobile_phone])
    expect(model.valid?).to eq(true)
  end

  it 'invalidates with a non 10 digit number', vcr: true do
    model = TwilioMockModel.new(invalid_phone)
    expect(model.valid?).to eq(false)
    expect(model.errors.full_messages.first).to eq('Number does not appear to be a valid phone number')
  end

  it 'invalidates without a number', vcr: true do
    model = TwilioMockModel.new('_')
    expect(model.valid?).to eq(false)
    expect(model.errors.full_messages.first).to eq('Number does not appear to be a valid phone number')
  end

  it 'invalidates with mutliple phone numbers', vcr: true do
    model = TwilioMockModel.new(mobile_phone, [mobile_phone, invalid_phone])
    expect(model.valid?).to eq(false)
    expect(model.errors.full_messages.first).to eq('Multiple numbers appears to include at least one invalid phone number')
  end
end
