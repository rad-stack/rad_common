require 'rails_helper'

RSpec.describe AppInfo, type: :service do
  let(:service) { described_class.new }

  describe 'application_tables' do
    subject { service.application_tables }

    let(:result) do
      %w[assistant_sessions attorneys categories clients companies contact_log_recipients contact_logs
         custom_reports divisions duplicates embeddings notification_security_roles notification_settings
         notification_types notifications saved_search_filters search_preferences security_roles statuses
         system_messages user_clients user_security_roles user_statuses users]
    end

    it { is_expected.to eq result }
  end

  describe 'application_models' do
    subject { service.application_models }

    let(:result) do
      %w[AssistantSession Attorney Category Client Company ContactLog ContactLogRecipient CustomReport
         Division Duplicate Embedding Notification NotificationSecurityRole NotificationSetting
         NotificationType SavedSearchFilter SearchPreference SecurityRole Status SystemMessage
         User UserClient UserSecurityRole UserStatus]
    end

    it { is_expected.to eq result }
  end

  describe 'audited_models' do
    subject { service.audited_models }

    let(:result) do
      %w[ActionText::RichText ActiveStorage::Attachment AssistantSession Attorney Category Client Company ContactLog
         ContactLogRecipient CustomReport Division NotificationSecurityRole NotificationSetting NotificationType SavedSearchFilter
         SearchPreference SecurityRole Status SystemMessage User UserClient UserSecurityRole]
    end

    it { is_expected.to eq result }
  end

  describe 'show_routes' do
    let(:result) { service.show_routes }

    let(:mock_route) do
      double('route',
             defaults: { action: 'show', controller: controller_name },
             path: double(spec: double(to_s: '/:id')),
             verb: 'GET')
    end

    let(:mock_model) do
      double('model', model_name: double(route_key: model_route_key, singular_route_key: model_singular_route_key))
    end

    before do
      allow(Rails.application.routes).to receive(:routes).and_return([mock_route])
      allow(service).to receive(:application_models).and_return([model_class_name])
      allow(model_class_name).to receive(:safe_constantize).and_return(mock_model)
    end

    context 'when controller matches route_key' do
      let(:controller_name) { 'users' }
      let(:model_class_name) { 'User' }
      let(:model_route_key) { 'users' }
      let(:model_singular_route_key) { 'user' }

      it 'returns the model name' do
        expect(result).to eq(['User'])
      end
    end

    context 'when controller matches singular_route_key (e.g. Equipment)' do
      let(:controller_name) { 'equipment' }
      let(:model_class_name) { 'Equipment' }
      let(:model_route_key) { 'equipment_index' }
      let(:model_singular_route_key) { 'equipment' }

      it 'returns the model name' do
        expect(result).to eq(['Equipment'])
      end
    end

    context 'when controller does not match either route key' do
      let(:controller_name) { 'other' }
      let(:model_class_name) { 'User' }
      let(:model_route_key) { 'users' }
      let(:model_singular_route_key) { 'user' }

      it 'does not return the model name' do
        expect(result).to eq([])
      end
    end
  end
end
