require 'rails_helper'

RSpec.describe RadCommon::Search, type: :service do
  describe 'results' do
    subject do
      described_class.new(query: Division,
                          filters: filters,
                          current_user: user,
                          params: {}).results
    end

    let!(:division) { create :division }

    context 'when using a like filter' do
      it 'filters results'
    end

    context 'when using a date filter' do
      it 'filters results'
    end

    context 'when using a select filter' do
      let(:filters) { [{ input_label: 'Owner', column: :owner_id, options: User.by_name }] }

      it 'filters results'

      context 'when authorized' do
        let(:user) { create :admin }

        it { is_expected.to eq [division] }
      end

      context 'when not authorized' do
        let(:user) { create :user }

        it { is_expected.not_to eq [division] }
      end
    end
  end

  describe 'search_params' do
    context 'when using default params' do
      it 'uses default params when params are not present'
      it 'overrides defaults params when params are present'
    end
  end
end
