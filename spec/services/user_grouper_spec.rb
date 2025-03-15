require 'rails_helper'

describe UserGrouper do
  subject do
    described_class.new(current_user, with_ids: with_ids, scopes: scopes, always_include: always_include).call
  end

  let(:current_user) { create :admin }
  let(:user) { create :user, first_name: 'Allan' }
  let(:another_user) { create :user, first_name: 'Bobby' }
  let!(:inactive_user) { create :user, :inactive }
  let(:client) { create :client }
  let(:another_client) { create :client, entered_by_user: user }
  let(:project) { create :project, client: client, entered_by_user: user }
  let(:task) { create :task, project: project, assigned_to_user: assigned_to_user }
  let(:active_client) { create :client_user, client: client }
  let(:another_active_client) { create :client_user, client: another_client }
  let(:with_ids) { false }
  let(:always_include) { nil }
  let(:scopes) { [] }

  # using notification is not ideal since we don't have a use case for this, but demonstrates a user association
  # available in all projects
  let(:notification_type) { Notifications::InvalidDataWasFoundNotification.main({}) }
  let(:notification) { create :notification, user: notification_user, notification_type: notification_type }

  before do
    allow(RadConfig).to receive_messages(twilio_verify_enabled?: false, require_mobile_phone?: false)

    user
    another_user
  end

  context 'with standard case' do
    let(:result) { [['Me', [current_user]], ['Users', [user, another_user]], ['Inactive', [inactive_user]]] }

    it { is_expected.to eq result }
  end

  context 'with scope' do
    let(:scopes) { [:with_mobile_phone] }
    let(:result) { [['Me', [current_user]], ['Users', [user, another_user]], ['Inactive', [inactive_user]]] }

    it { is_expected.to eq result }
  end

  context 'with scope without another user' do
    let(:scopes) { [:with_mobile_phone] }
    let(:another_user) { create :user, mobile_phone: nil }
    let(:result) { [['Me', [current_user]], ['Users', [user]], ['Inactive', [inactive_user]]] }

    it { is_expected.to eq result }
  end

  context 'with scope without me' do
    let(:scopes) { [:with_mobile_phone] }
    let(:current_user) { create :user, mobile_phone: nil }
    let(:result) { [['Users', [user, another_user]], ['Inactive', [inactive_user]]] }

    it { is_expected.to eq result }
  end

  context 'with always include' do
    context 'with active user' do
      let(:always_include) { user }
      let(:result) { [['Me', [current_user]], ['Users', [user, another_user]], ['Inactive', [inactive_user]]] }

      it { is_expected.to eq result }
    end

    context 'with inactive user' do
      let(:always_include) { inactive_user }
      let(:result) { [['Me', [current_user]], ['Users', [user, another_user]], ['Inactive', [inactive_user]]] }

      it { is_expected.to eq result }
    end

    context 'with active user not in scope' do
      let(:scopes) { [:with_mobile_phone] }
      let(:always_include) { user }
      let(:user) { create :user, first_name: 'Allan', mobile_phone: nil }
      let(:result) { [['Me', [current_user]], ['Users', [user, another_user]], ['Inactive', [inactive_user]]] }

      it { is_expected.to eq result }
    end

    context 'with inactive user not in scope' do
      let(:scopes) { [:with_mobile_phone] }
      let(:always_include) { inactive_user }
      let(:inactive_user) { create :user, :inactive, mobile_phone: nil }
      let(:result) { [['Me', [current_user]], ['Users', [user, another_user]], ['Inactive', [inactive_user]]] }

      xit { is_expected.to eq result }
    end

    context 'with active scope' do
      let(:always_include) { item_user }
      let(:scopes) { [:active] }

      context 'when item user is current user' do
        let(:item_user) { current_user }
        let(:result) { [['Me', [current_user]], ['Users', [user, another_user]]] }

        it { is_expected.to eq result }
      end

      context 'when item user is an active user' do
        let(:item_user) { user }
        let(:result) { [['Me', [current_user]], ['Users', [user, another_user]]] }

        it { is_expected.to eq result }
      end

      context 'when item user is an inactive user' do
        let(:item_user) { inactive_user }
        let(:result) { [['Me', [current_user]], ['Users', [user, another_user]], ['Inactive', [inactive_user]]] }

        it { is_expected.to eq result }
      end
    end
  end

  context 'with client user' do
    let(:always_include) { notification.user }
    let(:scopes) { [:active] }

    before { active_client }

    context 'with active user' do
      let(:notification_user) { user }
      let(:result) { [['Me', [current_user]], ['Users', [user, another_user]], ['Clients', [active_client]]] }

      xit { is_expected.to eq result }
    end

    context 'with inactive user' do
      let(:notification_user) { inactive_user }

      let(:result) do
        [['Me', [current_user]],
         ['Users', [user, another_user]],
         ['Clients', [active_client]],
         ['Inactive', [inactive_user]]]
      end

      xit { is_expected.to eq result }
    end
  end

  context "with ID's" do
    let(:with_ids) { true }

    context 'when including inactive' do
      let(:result) do
        [['Me', [[current_user, current_user.id]]],
         ['Users', [[user, user.id], [another_user, another_user.id]]],
         ['Inactive', [[inactive_user, inactive_user.id]]]]
      end

      it { is_expected.to eq result }
    end

    context 'when excluding inactive' do
      let(:scopes) { [:active] }

      let(:result) do
        [['Me', [[current_user, current_user.id]]], ['Users', [[user, user.id], [another_user, another_user.id]]]]
      end

      it { is_expected.to eq result }

      context 'with always include' do
        let(:always_include) { inactive_user }

        let(:result) do
          [['Me', [[current_user, current_user.id]]],
           ['Users', [[user, user.id], [another_user, another_user.id]]],
           ['Inactive', [[inactive_user, inactive_user.id]]]]
        end

        it { is_expected.to eq result }
      end
    end
  end
end
