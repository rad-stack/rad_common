require 'rails_helper'

RSpec.describe RadEnum, type: :service do
  describe 'db_options' do
    subject { described_class.new(Division, :division_status).db_options }

    let(:options) { [['Pending', 0], ['Active', 1], ['Inactive', 2]] }

    it { is_expected.to eq options }
  end
end
