require 'rails_helper'

RSpec.describe Contactable do
  describe 'validations' do
    it 'validates zipcodes' do
      %w[12345 12345-1234 00920].each do |item|
        check_zipcode item, true
      end

      %w[1234 123456 12345-123 12345-12345 12345-123A A2345 12345.8381].each do |item|
        check_zipcode item, false
      end
    end
  end

  private

    def check_zipcode(zipcode, valid)
      record = build :attorney, zipcode: zipcode
      expect(record.valid?).to be valid
    end
end
