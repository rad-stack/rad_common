require 'rails_helper'

RSpec.describe NotificationSettingsController, type: :controller do
  let(:user) { create :admin }
  let(:notification_type) { 'Notifications::NewUserSignedUpNotification' }

  before { sign_in user }

  let(:valid_attributes) { { notification_type: notification_type, enabled: false } }
  let(:invalid_attributes) { { notification_type: nil } }

  describe 'POST create' do
    context 'not authorized' do
      before { allow_any_instance_of(Notifications::Notification).to receive(:permitted_users).and_return([]) }

      it 'denies access' do
        post :create, params: { notification_setting: valid_attributes }
        expect(response.code).to eq '403'
      end
    end

    context 'authorized' do
      describe 'with valid params' do
        xit 'creates a new NotificationSetting' do
          expect {
            post :create, params: { notification_setting: valid_attributes }
          }.to change(NotificationSetting, :count).by(1)
        end

        xit 'redirects to the settings' do
          post :create, params: { notification_setting: valid_attributes }
          expect(response).to redirect_to(notification_settings_path)
        end
      end

      describe 'with invalid params' do
        xit 'redirects to the settings' do
          post :create, params: { notification_setting: invalid_attributes }
          expect(response).to redirect_to(notification_settings_path)
        end
      end
    end
  end
end
