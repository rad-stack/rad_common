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

  describe 'bypass_address_validation=' do
    subject(:company) { Company.main }

    it 'accepts true' do
      company.bypass_address_validation = true
      expect(company.bypass_address_validation?).to be true
    end

    it 'accepts false' do
      company.bypass_address_validation = false
      expect(company.bypass_address_validation?).to be false
    end

    it 'raises on string "false"' do
      expect { company.bypass_address_validation = 'false' }.to raise_error(ArgumentError, /must be a boolean/)
    end

    it 'raises on string "true"' do
      expect { company.bypass_address_validation = 'true' }.to raise_error(ArgumentError, /must be a boolean/)
    end

    it 'raises on nil' do
      expect { company.bypass_address_validation = nil }.to raise_error(ArgumentError, /must be a boolean/)
    end
  end

  describe 'bypass_address_validation' do
    subject(:company) { Company.main }

    it 'returns true when set to true' do
      company.bypass_address_validation = true
      expect(company.bypass_address_validation).to be true
    end

    it 'returns false when set to false' do
      company.bypass_address_validation = false
      expect(company.bypass_address_validation).to be false
    end

    it 'returns false when address_metadata is blank' do
      company.address_metadata = nil
      expect(company.bypass_address_validation).to be false
    end

    it 'returns false when the key is missing from address_metadata' do
      company.address_metadata = { 'valid' => true }
      expect(company.bypass_address_validation).to be false
    end

    it 'returns false (not the raw string) when JSON contains a stringy historical value' do
      company.update_column :address_metadata, { 'bypass_address_validation' => 'false' }
      company.reload
      expect(company.bypass_address_validation).to be false
    end
  end

  private

    def check_zipcode(zipcode, valid)
      record = build :attorney, zipcode: zipcode
      expect(record.valid?).to be valid
    end
end
