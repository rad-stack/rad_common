require 'rails_helper'

class TestPhoneModel
  include ActiveModel::Model
  attr_accessor :phone_number

  def initialize(phone_number)
    @phone_number = phone_number
  end

  def []=(attribute, value)
    public_send("#{attribute}=", value)
  end

  validates_with PhoneNumberValidator, fields: [:phone_number]
end

RSpec.describe PhoneNumberValidator do
  it 'can not be valid' do
    invalid_numbers = ['232332', '211-333-1111', '(432)-111-2222', '905.444.2111', '905 444 2111']

    invalid_numbers.each do |phone_number|
      model = TestPhoneModel.new(phone_number)
      expect(model).to be_invalid
      expect(model.errors.full_messages.to_s).to include 'number invalid, format must be'
    end
  end

  it 'can be valid' do
    model = TestPhoneModel.new('(211) 333-1111')
    expect(model).to be_valid
  end

  it 'converts a 10 digit number to a valid format' do
    number = '2813308004'
    model = TestPhoneModel.new(number)
    expect(model).to be_valid
    expect(model.phone_number).to eq('(281) 330-8004')
  end

  it 'identifies valid but fake numbers' do
    invalid_numbers = ['(999) 999-9999', '(000) 226-1245']

    invalid_numbers.each do |phone_number|
      model = TestPhoneModel.new(phone_number)
      expect(model).to be_invalid
      expect(model.errors.full_messages.to_s).to include 'number invalid, format must be'
    end
  end
end
