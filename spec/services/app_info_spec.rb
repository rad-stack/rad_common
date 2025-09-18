require 'rails_helper'

RSpec.describe AppInfo, type: :service do
  let(:service) { described_class.new }

  describe 'application_tables' do
    subject { service.application_tables }

    let(:result) do
      %w[attorneys categories clients companies contact_log_recipients contact_logs
         divisions duplicates embeddings notification_security_roles notification_settings
         notification_types notifications saved_search_filters security_roles statuses system_messages
         user_clients user_security_roles user_statuses users]
    end

    it { is_expected.to eq result }
  end

  describe 'application_models' do
    subject { service.application_models }

    let(:result) do
      %w[Attorney Category Client Company ContactLog ContactLogRecipient
         Division Duplicate Embedding Notification NotificationSecurityRole NotificationSetting
         NotificationType SavedSearchFilter SecurityRole Status SystemMessage
         User UserClient UserSecurityRole UserStatus]
    end

    it { is_expected.to eq result }
  end

  describe 'audited_models' do
    subject { service.audited_models }

    let(:result) do
      %w[ActionText::RichText ActiveStorage::Attachment Attorney Category Client Company ContactLog ContactLogRecipient
         Division NotificationSecurityRole NotificationSetting NotificationType SavedSearchFilter SecurityRole Status
         User UserClient UserSecurityRole]
    end

    it { is_expected.to eq result }
  end
end
