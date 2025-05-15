require 'rails_helper'

RSpec.describe RadCommon::LikeFilter, type: :service do
  describe '#apply_filter' do
    subject do
      filter.apply_filter(Division.all, params).pluck(:id)
    end

    let(:filter) { described_class.new(column: :name) }
    let!(:division_1) { create :division, name: 'Division 1' }
    let!(:division_2) { create :division, name: 'Division 2' }
    let!(:division_3) { create :division, name: 'Division 123' }
    let(:search_term) { 'Division 1' }

    let(:params) do
      { filter.match_type_param => match_type, filter.like_input => search_term }
    end

    context 'when match type is exact' do
      let(:match_type) { 'exact' }

      it { is_expected.to include division_1.id }
    end

    context 'when match type is contains' do
      let(:match_type) { 'contains' }
      let(:search_term) { 'Div' }

      it { is_expected.to include division_1.id }
      it { is_expected.to include division_2.id }
      it { is_expected.to include division_3.id }
    end

    context 'when match type is does_not_contain' do
      let(:match_type) { 'does_not_contain' }

      it { is_expected.not_to include division_1.id }
      it { is_expected.to include division_2.id }
      it { is_expected.not_to include division_3.id }
    end

    context 'when match type is starts_with' do
      let(:match_type) { 'starts_with' }

      it { is_expected.not_to include division_2.id }
    end

    context 'when match type is does_not_start_with' do
      let(:match_type) { 'does_not_start_with' }

      it { is_expected.to include division_2.id }
    end

    context 'when match type is ends_with' do
      let(:match_type) { 'ends_with' }
      let(:search_term) { '123' }

      it { is_expected.to include division_3.id }
    end

    context 'when match type is does_not_end_with' do
      let(:match_type) { 'does_not_end_with' }
      let(:search_term) { '123' }

      it { is_expected.not_to include division_3.id }
    end
  end
end
