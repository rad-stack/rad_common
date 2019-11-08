require 'rails_helper'

RSpec.describe RadCommon::Search, type: :service do
  describe 'results' do
    subject do
      described_class.new(query: Division,
                          filters: filters,
                          sort_columns: sorts,
                          current_user: user,
                          params: {}).results
    end

    let!(:division) { create :division }
    let(:filters) { [{ input_label: 'Owner', column: :owner_id, options: User.by_name }] }

    # TODO: sorts should be optional, remove from here when fixed
    let(:sorts) { [{ column: 'name', label: 'Name', direction: 'desc' }] }

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
