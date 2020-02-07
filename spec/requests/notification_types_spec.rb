require 'rails_helper'

RSpec.describe 'NotificationTypes', type: :request do
  let(:user) { create :admin }
  let(:notification_type) { create :notification_type }

  before { login_as user, scope: :user }

  describe 'PUT update' do
    let(:valid_attributes) { { security_roles: [user.security_roles.first.id.to_s] } }
    let(:invalid_attributes) { { security_roles: %w[111 999] } }

    describe 'with valid params' do
      it 'updates the requested notification_type' do
        expect(notification_type.security_roles.count).to eq 0
        put "/rad_common/notification_types/#{notification_type.to_param}", params: { notification_type: valid_attributes }
        notification_type.reload
        expect(notification_type.security_roles.count).to eq 1
      end

      it 'redirects to the notification_type' do
        put "/rad_common/notification_types/#{notification_type.to_param}", params: { notification_type: valid_attributes }
        expect(response).to redirect_to('/rad_common/notification_types')
      end
    end

    describe 'with invalid params' do
      it 're-renders the edit template' do
        put "/rad_common/notification_types/#{notification_type.to_param}", params: { notification_type: invalid_attributes }
        expect(response.body).to include 'Please review the problems below'
      end
    end
  end
end
