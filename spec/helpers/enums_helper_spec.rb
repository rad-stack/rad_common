require 'rails_helper'

describe EnumsHelper do
  let(:division) { create :division }

  describe 'enum_to_translated_option' do
    let(:error_message) { "enum division_status_xxx on Division doesn't exist" }

    it 'translates the value' do
      expect(enum_to_translated_option(division, :division_status)).to eq 'Active'
    end

    it 'handles nil' do
      division.division_status = nil
      expect(enum_to_translated_option(division, :division_status)).to be_nil
    end

    it 'handles blank' do
      division.division_status = ''
      expect(enum_to_translated_option(division, :division_status)).to be_nil
    end

    it 'raises error when missing enum' do
      expect { enum_to_translated_option(division, :division_status_xxx) }.to raise_error(error_message)
    end
  end

  describe 'options_for_enum' do
    subject { options_for_enum(Division, :division_status) }

    let(:options) { [%w[Pending status_pending], %w[Active status_active], %w[Inactive status_inactive]] }
    let(:error_message) { "enum division_status_xxx on Division doesn't exist" }

    it { is_expected.to eq options }

    it 'raises error when missing enum' do
      expect { options_for_enum(Division, :division_status_xxx) }.to raise_error(error_message)
    end
  end
end
