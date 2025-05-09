require 'rails_helper'

RSpec.describe RadEnum, type: :service do
  describe 'options' do
    subject { described_class.new(Division, :division_status).options }

    let(:options) { [%w[Pending status_pending], %w[Active status_active], %w[Inactive status_inactive]] }

    it { is_expected.to eq options }
  end

  describe 'db_options' do
    subject { described_class.new(Division, :division_status).db_options }

    let(:options) { [['Pending', 0], ['Active', 1], ['Inactive', 2]] }

    it { is_expected.to eq options }
  end

  describe 'db_value' do
    subject { described_class.new(Division, :division_status).db_value('status_active') }

    it { is_expected.to eq 1 }
  end
end
