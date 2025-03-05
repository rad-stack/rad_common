require 'rails_helper'

RSpec.describe 'Notification Settings', type: :request do
  let(:notification_type) { create :new_user_signed_up_notification }

  before { login_as user, scope: :user }

  describe 'POST create' do
    let(:attributes) do
      { notification_type_id: notification_type.id,
        enabled: false,
        email: false,
        feed: false,
        sms: false,
        user_id: target_user.id }
    end

    context 'when admin' do
      let(:user) { create :admin }

      context 'with their settings' do
        let(:target_user) { user }

        context 'when valid' do
          it 'creates' do
            expect {
              post '/rad_common/notification_settings', params: { notification_setting: attributes }
            }.to change(NotificationSetting, :count).by(1)
          end

          it 'responds with success json' do
            post '/rad_common/notification_settings', params: { notification_setting: attributes }
            expect(response.body).to include('The setting was successfully saved.')
          end
        end

        context 'when invalid' do
          let(:attributes) { { notification_type_id: nil, enabled: false, user_id: target_user.id } }

          it 'fails' do
            expect {
              post '/rad_common/notification_settings', params: { notification_setting: attributes }
            }.not_to change(NotificationSetting, :count)
          end
        end
      end

      context "with another's settings" do
        let(:target_user) { create :user }

        it 'creates' do
          expect {
            post '/rad_common/notification_settings', params: { notification_setting: attributes }
          }.to change(NotificationSetting, :count).by(1)
        end
      end
    end

    context 'when user' do
      let(:security_role) { create :security_role }
      let(:user) { create :user, security_roles: [security_role] }

      before do
        NotificationSecurityRole.create! notification_type_id: notification_type.id, security_role: security_role
      end

      context 'with their settings' do
        let(:target_user) { user }

        it 'creates' do
          user
          expect {
            post '/rad_common/notification_settings', params: { notification_setting: attributes }
          }.to change(NotificationSetting, :count).by(1)
        end
      end

      context "with another's settings" do
        let(:target_user) { create :user }

        before { user.user_security_roles.delete_all }

        it 'denies access' do
          post '/rad_common/notification_settings', params: { notification_setting: attributes }
          expect(response.code).to eq '403'
        end
      end
    end
  end
end
