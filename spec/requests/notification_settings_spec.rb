require 'rails_helper'

RSpec.describe 'Notification Settings', type: :request do
  let(:notification_type) { create :notification_type }

  before { login_as(user, scope: :user) }

  describe 'POST create' do
    subject { post '/rad_common/notification_settings', params: { notification_setting: attributes } }

    let(:attributes) { { notification_type_id: notification_type.id, enabled: false, user_id: target_user.id } }

    context 'admin' do
      let(:user) { create :admin }

      context 'their settings' do
        let(:target_user) { user }

        context 'valid' do
          it 'creates' do
            expect { subject }.to change(NotificationSetting, :count).by(1)
          end

          it 'redirects to the settings' do
            subject
            expect(response).to redirect_to('/rad_common/notification_settings')
          end
        end

        context 'invalid' do
          let(:attributes) { { notification_type_id: nil, enabled: false, user_id: target_user.id } }

          it 'fails' do
            expect { subject }.to change(NotificationSetting, :count).by(0)
          end
        end
      end

      context "another's settings" do
        let(:target_user) { create :user }

        it 'creates' do
          expect { subject }.to change(NotificationSetting, :count).by(1)
        end
      end
    end

    context 'user' do
      let(:security_role) { create :security_role }
      let(:user) { create :user, security_roles: [security_role] }

      before do
        NotificationSecurityRole.create! notification_type_id: notification_type.id, security_role: security_role
      end

      context 'their settings' do
        let(:target_user) { user }

        it 'creates' do
          user
          expect { subject }.to change(NotificationSetting, :count).by(1)
        end
      end

      context "another's settings" do
        let(:target_user) { create :user }

        before { user.update! security_roles: [] }

        it 'denies access' do
          subject
          expect(response.code).to eq '403'
        end
      end
    end
  end
end
