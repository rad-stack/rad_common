require 'rails_helper'

class TestModel
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
  it 'phone number format must be valid' do
    invalid_numbers = ['232332', '211-333-1111', '(432)-111-2222', '905.444.2111']
    invalid_numbers.each do |phone_number|
      model = TestModel.new(phone_number)
      expect(model).to be_invalid
    end
  end

  it 'converts a 10 digit number to a valid format' do
    number = '2813308004'
    model = TestModel.new(number)
    expect(model).to be_valid
    expect(model.phone_number).to eq('(281) 330-8004')
  end

  it 'identifies valid but fake numbers' do
    number = '(999) 999-9999'
    model = TestModel.new(number)
    expect(model).to be_invalid
  end
end
