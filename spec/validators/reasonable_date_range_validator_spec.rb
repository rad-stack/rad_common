require 'rails_helper'

class MockModelWithDateValidations
  include ActiveModel::Validations
  attr_reader :date

  validates :date, reasonable_date_range: true
  def initialize(date)
    @date = date
  end

  def date_changed?
    true
  end
end

describe ReasonableDateRangeValidator do
  it 'valid when date is reasonable' do
    date = Date.current + 3.years
    model = MockModelWithDateValidations.new(date)
    expect(model).to be_valid
  end

  it 'validates time objects' do
    time = Time.current
    model = MockModelWithDateValidations.new(time)
    expect(model).to be_valid
  end

  it 'allows blank by convention' do
    date = nil
    model = MockModelWithDateValidations.new(date)
    expect(model).to be_valid
  end

  it 'invalidates when too far in the past' do
    date = Date.current - 2000.years
    model = MockModelWithDateValidations.new(date)
    expect(model).not_to be_valid
    expect(model.errors[:date]).to include('is not a reasonable date')
  end

  it 'invalidates when too far in the future' do
    date = Date.current + 3000.years
    model = MockModelWithDateValidations.new(date)
    expect(model).not_to be_valid
    expect(model.errors[:date]).to include('is not a reasonable date')
  end
end
