require 'rails_helper'

RSpec.describe RadCommon::Search, type: :service do
  let(:user) { create(:user) }

  describe 'results' do
    subject do
      described_class.new(query: query,
                          filters: filters,
                          current_user: user,
                          params: params).results
    end

    let!(:division) { create :division }

    context 'when using a like filter' do
      let!(:role_1) { create(:security_role, name: 'foo') }
      let!(:role_2) { create(:security_role, name: 'bar') }
      let(:query) { SecurityRole }
      let(:filters) { [{ column: :name, type: RadCommon::LikeFilter }] }
      let(:params) { ActionController::Parameters.new(search: { name_like: 'foo' }) }

      it 'filters results' do
        expect(subject).to include role_1
        expect(subject).not_to include role_2
      end
    end

    context 'when using a date filter' do
      let(:query) { User.joins(:security_roles) }
      let(:user_1) { create :user, confirmed_at: 2.days.ago }
      let(:user_2) { create :user, confirmed_at: 3.days.from_now }
      let!(:user_3) { create :user, confirmed_at: DateTime.current.end_of_day }
      let!(:user_4) { create :user, confirmed_at: 2.days.ago, security_roles: [] }
      let(:filters) { [{ column: :confirmed_at, type: RadCommon::DateFilter }] }
      let(:params) do
        ActionController::Parameters.new(search: { confirmed_at_start: 3.days.ago.strftime('%Y-%m-%d'),
                                                   confirmed_at_end: DateTime.current.strftime('%Y-%m-%d') })
      end

      it 'filters results' do
        expect(subject).to include user_1
        expect(subject).to include user_3
        expect(subject).not_to include user_4
        expect(subject).not_to include user_2
      end
    end

    context 'when using a select filter' do
      let(:query) { User }
      let(:user_active) { create :user, user_status: UserStatus.default_active_status }
      let(:user_pending) { create :user, user_status: UserStatus.default_pending_status }
      let(:filters) { [{ column: :user_status_id, options: UserStatus.by_id }] }
      let(:params) { ActionController::Parameters.new(search: { user_status_id: UserStatus.default_active_status.id }) }

      it 'filters results' do
        expect(subject).to include user_active
        expect(subject).not_to include user_pending
      end
    end

    describe 'authorized' do
      let(:query) { Division }
      let(:filters) { [{ input_label: 'Owner', column: :owner_id, options: User.by_name }] }
      let(:params) { ActionController::Parameters.new }

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

  describe 'filters' do
    subject do
      described_class.new(query: query,
                          filters: filters,
                          current_user: user,
                          params: params).filters
    end

    context 'when using scope_values' do
      let(:query) { Division }
      let(:filters) { [{ column: :owner_id, options: User.by_name, scope_values: { 'Pending Values': :pending } }] }
      let(:params) { ActionController::Parameters.new }

      it 'has both scope and normal options' do
        expect(subject.first.input_options).to include ['Pending Values', 'Pending Values']
        expect(subject.first.input_options).to include [User.by_name.first.to_s, User.by_name.first.id]
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
