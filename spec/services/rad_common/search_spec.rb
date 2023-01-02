require 'rails_helper'

RSpec.describe RadCommon::Search, type: :service do
  let(:user) { create(:user) }

  describe 'results' do
    subject(:search) do
      described_class.new(query: query,
                          filters: filters,
                          current_user: user,
                          search_name: 'divisions_search',
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
        expect(search).to include role_1
        expect(search).not_to include role_2
      end
    end

    context 'when using a date filter' do
      let(:query) { User.joins(:security_roles) }
      let(:user_1) { create :user, confirmed_at: 2.days.ago }
      let(:user_2) { create :user, confirmed_at: 3.days.from_now }
      let!(:user_3) { create :user, confirmed_at: DateTime.current.end_of_day }

      let!(:user_4) do
        create :user, confirmed_at: 2.days.ago, security_roles: [], user_status: UserStatus.default_inactive_status
      end

      let(:filters) { [{ column: :confirmed_at, type: RadCommon::DateFilter }] }
      let(:params) do
        ActionController::Parameters.new(search: { confirmed_at_start: 3.days.ago.strftime('%Y-%m-%d'),
                                                   confirmed_at_end: DateTime.current.strftime('%Y-%m-%d') })
      end

      it 'filters results' do
        expect(search).to include user_1
        expect(search).to include user_3
        expect(search).not_to include user_4
        expect(search).not_to include user_2
      end
    end

    context 'when using a date filter scope' do
      let(:query) { Attorney }
      let(:attorney_1) { create :attorney, created_at: 2.days.ago }
      let(:attorney_2) { create :attorney, created_at: 3.days.from_now }
      let!(:attorney_3) { create :attorney, created_at: DateTime.current.end_of_day }
      let!(:attorney_4) { create :attorney, created_at: 2.days.ago }
      let(:filters) { [{ column: :created_at, type: RadCommon::DateFilter, scope: :created_between }] }
      let(:params) do
        ActionController::Parameters.new(search: { created_at_start: 3.days.ago.strftime('%Y-%m-%d'),
                                                   created_at_end: DateTime.current.strftime('%Y-%m-%d') })
      end

      it 'filters results' do
        expect(search).to include attorney_1
        expect(search).to include attorney_3
        expect(search).to include attorney_4
        expect(search).not_to include attorney_2
      end
    end

    context 'when using a joins date filter' do
      let(:query) { SystemMessage.joins(:user) }
      let!(:message_1) { create :system_message, :email, user: create(:user, created_at: 1.day.ago) }
      let!(:message_2) { create :system_message, :email, user: create(:user, created_at: 2.days.ago) }
      let!(:message_3) { create :system_message, :email, user: create(:user, created_at: 5.days.ago) }
      let(:filters) { [{ column: 'users.created_at', type: RadCommon::DateFilter }] }
      let(:params) do
        ActionController::Parameters.new(search: { 'users.created_at_start': 3.days.ago.strftime('%Y-%m-%d'),
                                                   'users.created_at_end': Date.current.strftime('%Y-%m-%d') })
      end

      it 'filters results' do
        expect(search).to include message_1
        expect(search).to include message_2
        expect(search).not_to include message_3
      end
    end

    context 'when using a select filter' do
      let(:query) { User }
      let(:user_active) { create :user, user_status: UserStatus.default_active_status }
      let(:user_pending) { create :user, user_status: UserStatus.default_pending_status }
      let(:filters) { [{ column: :user_status_id, options: UserStatus.by_id }] }
      let(:params) { ActionController::Parameters.new(search: { user_status_id: UserStatus.default_active_status.id }) }

      it 'filters results' do
        expect(search).to include user_active
        expect(search).not_to include user_pending
      end
    end

    context 'when a filter has a default value' do
      let(:query) { Division }
      let(:filters) { [{ column: :owner_id, options: User.by_name, default_value: user.id }] }
      let(:user) { create :admin }
      let!(:other_division) { create(:division, created_at: 2.days.ago) }
      let!(:default_division) { create(:division, owner: user) }

      context 'when in a blank query' do
        let(:params) { ActionController::Parameters.new }

        it 'filters results using default value' do
          expect(search).to include default_division
          expect(search).not_to include other_division
        end
      end

      context 'when in a date filter' do
        let(:filters) do
          [{ column: :created_at, type: RadCommon::DateFilter,
             default_start_value: 1.day.ago, default_end_value: 2.days.from_now }]
        end
        let(:params) { ActionController::Parameters.new }

        it 'filters results using default value' do
          expect(search).to include default_division
          expect(search).not_to include other_division
        end
      end

      context 'when in a query where value is selected' do
        let(:params) { ActionController::Parameters.new(search: { owner_id: other_division.owner_id }) }

        it 'filters results using selected value' do
          expect(search).to include other_division
          expect(search).not_to include default_division
        end
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

  describe 'user filter_defaults' do
    subject(:search) do
      described_class.new(query: query,
                          filters: filters,
                          current_user: user,
                          search_name: 'divisions_search',
                          sticky_filters: sticky_filters,
                          params: params).results
    end

    let(:sticky_filters) { true }
    let(:query) { User }
    let!(:user_active) { create :user, user_status: UserStatus.default_active_status }
    let!(:user_pending) { create :user, user_status: UserStatus.default_pending_status }
    let(:filters) { [{ column: :user_status_id, options: UserStatus.by_id }] }
    let(:params) { ActionController::Parameters.new }

    before do
      default_values = { divisions_search: { user_status_id: UserStatus.default_active_status.id } }
      user.update!(filter_defaults: default_values)
    end

    context 'when no params are passed' do
      context 'with sticky filters' do
        it 'filters from stored user default values' do
          expect(search).to include user_active
          expect(search).not_to include user_pending
        end
      end

      context 'without sticky filters' do
        let(:sticky_filters) { false }

        it 'filters from stored user default values' do
          expect(search).to include user_active
          expect(search).to include user_pending
        end
      end
    end

    context 'when clear_filters params are passed in' do
      let(:params) { ActionController::Parameters.new(clear_filters: true) }

      it 'resets stored user default values' do
        expect { search }.to change { user.filter_defaults['divisions_search']['user_status_id'] }
          .from(UserStatus.default_active_status.id).to(nil)
        expect(search).to include user_active
        expect(search).to include user_pending
      end
    end
  end

  describe 'equals filter' do
    subject(:search) do
      described_class.new(query: query,
                          filters: filters,
                          search_name: 'users_search',
                          current_user: user,
                          params: params)
    end

    let(:query) { User }
    let!(:user_1) { create :user }
    let(:filters) { [{ column: :id, type: RadCommon::EqualsFilter, data_type: :integer }] }

    let(:params) do
      ActionController::Parameters.new(search: { id_equals: user_1.id })
    end

    before { create :user }

    it 'shows correct results' do
      expect(search.results.count).to eq 1
    end

    context 'with a scope' do
      let(:filters) do
        [{ column: :permission,
           type: RadCommon::EqualsFilter,
           data_type: :string,
           scope: :by_permission }]
      end

      let(:params) do
        ActionController::Parameters.new(search: { permission_equals: 'create_division' })
      end

      it 'shows correct results' do
        User.first.security_roles.first.update!(create_division: true)
        expect(search.results.count).to eq 1
      end
    end
  end

  describe 'custom date filter' do
    subject(:search) do
      described_class.new(query: query,
                          filters: filters,
                          search_name: 'divisions_search',
                          current_user: user,
                          params: params)
    end

    let(:query) { User.joins(:security_roles) }
    let(:filters) { [{ column: :custom_column, type: RadCommon::DateFilter, custom: true }] }

    let(:params) do
      ActionController::Parameters.new(search: { custom_column_start: 3.days.from_now.beginning_of_day,
                                                 custom_column_end: 3.days.from_now.end_of_day })
    end

    before do
      create :user, confirmed_at: 1.day.ago
      create :user, confirmed_at: 3.days.from_now
    end

    it 'is included in search params' do
      expect(search.search_params.keys).to include 'custom_column_start'
      expect(search.search_params.keys).to include 'custom_column_end'
    end

    it 'runs query using custom value' do
      expect(search.results.where('confirmed_at >= ? AND confirmed_at <= ?',
                                  search.search_params['custom_column_start'],
                                  search.search_params['custom_column_end']).count).to eq 1
    end
  end

  describe 'valid?' do
    subject(:valid) { search.valid? }

    let(:search) do
      described_class.new(query: query,
                          filters: filters,
                          search_name: 'divisions_search',
                          current_user: user,
                          params: params)
    end
    let(:query) { User.joins(:security_roles) }
    let(:filters) { [{ column: :confirmed_at, type: RadCommon::DateFilter }] }

    context 'with invalid date params' do
      let(:params) do
        ActionController::Parameters.new(search: { confirmed_at_start: '2019-13-01',
                                                   confirmed_at_end: '2019-12-02' })
      end

      it 'returns false and displays error message' do
        expect(valid).to be false
        expect(search.error_messages).to eq 'Invalid date entered for confirmed_at'
      end
    end

    context 'when start date after end date' do
      let(:params) do
        ActionController::Parameters.new(search: { confirmed_at_start: '2019-12-03',
                                                   confirmed_at_end: '2019-12-02' })
      end

      it 'returns false and displays error message' do
        expect(valid).to be false
        expect(search.error_messages).to eq 'Confirmed At Start must be before Confirmed At End'
      end
    end
  end

  describe 'scope value filters' do
    subject(:search) do
      described_class.new(query: query,
                          filters: filters,
                          search_name: 'divisions_search',
                          current_user: user,
                          params: params).filters
    end

    context 'when using mixed scope_values' do
      let(:query) { Division }
      let(:filters) { [{ column: :owner_id, options: User.by_name, scope_values: { 'Pending Values': :pending } }] }
      let(:params) { ActionController::Parameters.new }

      it 'has both scope and normal options' do
        expect(search.first.input_options).to include ['Pending Values', 'Pending Values']
        expect(search.first.input_options).to include [User.by_name.first.to_s, User.by_name.first.id]
      end
    end

    context 'when using only scope_values' do
      let(:query) { Division }
      let(:filters) { [{ input_label: 'Type', name: :external, scope_values: %i[internal external] }] }
      let(:params) { ActionController::Parameters.new }

      it 'has both scope options' do
        expect(search.first.input_options.map(&:first)).to eq %w[Internal External]
      end
    end

    context 'when using scope_value in grouped options' do
      let(:query) { Division }
      let(:filters) do
        [{ column: :owner_id, input_label: 'Users', grouped: true,
           options: [['...', [user, { scope_value: :unassigned }]],
                     ['Active', User.active.by_name],
                     ['Inactive', User.inactive.by_name]] }]
      end
      let(:params) { ActionController::Parameters.new }
      let(:group_values) { search.first.input_options.map(&:last) }

      it 'has both scope and normal options' do
        expect(group_values).to include [[user.to_s, user.id], %w[Unassigned unassigned]]
      end
    end
  end

  describe 'search_params' do
    subject(:search) do
      described_class.new(query: query,
                          filters: filters,
                          search_name: 'divisions_search',
                          current_user: user,
                          params: params)
    end

    let(:query) { Division }
    let!(:user_1) { create(:user) }
    let!(:user_2) { create(:user) }
    let(:filters) do
      [{ column: :owner_id, input_label: 'Users', options: User.all, default_value: user_1.id }]
    end
    let(:params) { ActionController::Parameters.new }

    context 'when using default params and params are not present' do
      it 'uses default params' do
        expect(search.filters.first.selected_value(search)).to eq user_1.id
      end
    end

    context 'when using default params and params are present' do
      let(:params) do
        ActionController::Parameters.new(search: { owner_id: user_2.id })
      end

      it 'overrides defaults params' do
        expect(search.filters.first.selected_value(search)).to eq user_2.id
      end
    end
  end
end
