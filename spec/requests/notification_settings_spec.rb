require 'rails_helper'

RSpec.describe 'Notification Settings', type: :request do
  let(:user) { create :admin }
  let(:notification_type) { 'Notifications::NewUserSignedUpNotification' }

  before { login_as(user, scope: :user)}

  let(:valid_attributes) { { notification_type: notification_type, enabled: false } }
  let(:invalid_attributes) { { notification_type: nil } }

  describe 'POST create' do
    context 'not authorized' do
      before { allow_any_instance_of(Notifications::Notification).to receive(:permitted_users).and_return([]) }

      it 'denies access' do
        post '/rad_common/notification_settings', params: { notification_setting: valid_attributes }
        expect(response.code).to eq '403'
      end
    end

    context 'authorized' do
      describe 'with valid params' do
        it 'creates a new NotificationSetting' do
          expect {
            post '/rad_common/notification_settings', params: { notification_setting: valid_attributes }
          }.to change(NotificationSetting, :count).by(1)
        end

        it 'redirects to the settings' do
          post '/rad_common/notification_settings', params: { notification_setting: valid_attributes }
          expect(response).to redirect_to('/rad_common/notification_settings')
        end
      end

      describe 'with invalid params' do
        it 'redirects to the settings' do
          post '/rad_common/notification_settings', params: { notification_setting: invalid_attributes }
          expect(response).to redirect_to('/rad_common/notification_settings')
        end
      end
    end
  end
end
