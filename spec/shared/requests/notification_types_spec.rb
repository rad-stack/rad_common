require 'rails_helper'

RSpec.describe 'Notification Types', type: :request do
  let(:user) { create :admin }
  let(:another_role) { create :security_role }
  let(:notification_type) { create :new_user_signed_up_notification }

  before { login_as user, scope: :user }

  describe 'PUT update' do
    let(:valid_attributes) do
      { active: true, security_roles: [user.security_roles.first.id.to_s, another_role.id.to_s] }
    end

    let(:invalid_attributes) { { security_roles: [] } }

    describe 'with valid params' do
      it 'updates the requested notification_type' do
        expect(notification_type.security_roles.count).to eq 1
        put "/rad_common/notification_types/#{notification_type.to_param}",
            params: { notifications_new_user_signed_up_notification: valid_attributes }
        notification_type.reload
        expect(notification_type.security_roles.count).to eq 2
      end

      it 'redirects to the notification_type' do
        put "/rad_common/notification_types/#{notification_type.to_param}",
            params: { notifications_new_user_signed_up_notification: valid_attributes }
        expect(response).to redirect_to('/rad_common/notification_types')
      end
    end

    describe 'with invalid params' do
      it 're-renders the edit template' do
        put "/rad_common/notification_types/#{notification_type.to_param}",
            params: { notifications_new_user_signed_up_notification: invalid_attributes }
        expect(response.body).to include 'Please review the problems below'
      end
    end
  end
end
