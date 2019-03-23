require 'rails_helper'

RSpec.describe NotificationSettingsController, type: :controller do
  let(:user) { create :admin }
  let(:notification_setting) { create :notification_setting, user: user }

  before do
    sign_in user
  end

  let(:valid_attributes) { { notification_type: 'Notifications::NewUserSignedUpNotification', enabled: false } }

  let(:invalid_attributes) do
    { notification_type: nil }
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new NotificationSetting' do
        expect {
          post :create, params: { notification_setting: valid_attributes }
        }.to change(NotificationSetting, :count).by(1)
      end

      it 'redirects to the settings' do
        post :create, params: { notification_setting: valid_attributes }
        expect(response).to redirect_to(notification_settings_path)
      end
    end

    describe 'with invalid params' do
      it 'redirects to the settings' do
        post :create, params: { notification_setting: invalid_attributes }
        expect(response).to redirect_to(notification_settings_path)
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) do
        { notification_type: 'bar' }
      end

      it 'updates the requested notification_setting' do
        put :update, params: { id: notification_setting.to_param, notification_setting: new_attributes }
        notification_setting.reload
        expect(notification_setting.notification_type).to eq('bar')
      end

      it 'redirects to the settings' do
        put :update, params: { id: notification_setting.to_param, notification_setting: valid_attributes }
        expect(response).to redirect_to(notification_settings_path)
      end
    end

    describe 'with invalid params' do
      it 'redirects to the settings' do
        put :update, params: { id: notification_setting.to_param, notification_setting: invalid_attributes }
        expect(response).to redirect_to(notification_settings_path)
      end
    end
  end
end
