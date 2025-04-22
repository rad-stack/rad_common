require 'rails_helper'

RSpec.describe RadCommon::ArrayFilter, type: :model do
  describe '#apply_filter' do
    subject { filter.apply_filter(Division.all, params).pluck(:id) }

    let!(:division_1) { create :division, tags: %w[Finance Sales] }
    let!(:division_2) { create :division, tags: %w[Finance Sales HR] }
    let!(:division_3) { create :division, tags: %w[Sales Marketing] }
    let(:column) { 'tags' }
    let(:options) { Division::TAG_OPTIONS }
    let(:filter) { described_class.new(column: column, options: options, match_type: match_type, input_label: 'Tags') }

    before do
      create :division
      create :division, tags: ['HR']
    end

    context 'when the filter value is blank' do
      let(:match_type) { :exact }
      let(:params) { ActionController::Parameters.new(filter.searchable_name => '') }

      it { is_expected.to eq(Division.pluck(:id)) }
    end

    context 'when the filter value is provided as a comma-separated string' do
      let(:params) { ActionController::Parameters.new(filter.searchable_name => 'Finance, Sales') }

      context 'with match_type :exact' do
        let(:match_type) { :exact }

        it { is_expected.to eq([division_1.id]) }
      end

      context 'with match_type :all' do
        let(:match_type) { :all }

        it { is_expected.to eq([division_1.id, division_2.id]) }
      end

      context 'with match_type :any' do
        let(:match_type) { :any }

        it { is_expected.to contain_exactly(division_1.id, division_2.id, division_3.id) }
      end
    end

    context 'when the filter value is provided as an array with blank elements' do
      let(:match_type) { :exact }
      let(:params) { ActionController::Parameters.new(filter.searchable_name => ['Finance', '  ', 'Sales', '']) }

      it { is_expected.to eq([division_1.id]) }
    end
  end
end
