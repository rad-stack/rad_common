require 'rails_helper'

RSpec.describe RadCommon::AppInfo, type: :service do
  let(:service) { described_class.new }

  describe 'application_tables' do
    subject { service.application_tables }

    let(:result) do
      %w[companies divisions notification_security_roles notification_settings notification_types security_roles
         security_roles_users statuses system_messages user_statuses users]
    end

    it { is_expected.to eq result }
  end

  describe 'application_models' do
    subject { service.application_models }

    let(:result) do
      %w[Company Division NotificationSecurityRole NotificationSetting NotificationType SecurityRole SecurityRolesUser
         Status SystemMessage User UserStatus]
    end

    it { is_expected.to eq result }
  end

  describe 'audited_models' do
    subject { service.audited_models }

    let(:result) do
      %w[Company Division NotificationSecurityRole NotificationSetting SecurityRole SecurityRolesUser Status User]
    end

    it { is_expected.to eq result }
  end

  describe 'portal_host_name' do
    pending 'works'
  end
end
