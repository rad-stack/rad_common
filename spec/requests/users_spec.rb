require 'rails_helper'

RSpec.describe 'Users' do
  describe 'POST /auth/users (sign-up)' do
    context 'when the submitted email matches an invited-but-not-accepted user' do
      let(:invite_email) { "invited.user@#{Company.main.valid_user_domains.first}" }
      let!(:security_role) { create :security_role, allow_invite: true, allow_sign_up: true }

      let!(:invited) do
        User.invite!(email: invite_email,
                     first_name: 'Layla',
                     last_name: 'Eagleton-Bruno',
                     mobile_phone: create(:phone_number, :mobile),
                     initial_security_role_id: security_role.id)
      end

      it 'does not overwrite the invited user with form data' do
        expect(invited).to be_persisted
        expect(invited.invitation_accepted_at).to be_nil

        post user_registration_path, params: {
          user: { email: invite_email,
                  password: 'cOmpl3x_p@55w0rd',
                  password_confirmation: 'cOmpl3x_p@55w0rd',
                  first_name: '',
                  last_name: '',
                  mobile_phone: '' }
        }

        invited.reload
        expect(invited.first_name).to eq 'Layla'
        expect(invited.last_name).to eq 'Eagleton-Bruno'
      end

      it 'redirects to root with a pending-invitation alert' do
        post user_registration_path, params: {
          user: { email: invite_email,
                  password: 'cOmpl3x_p@55w0rd',
                  password_confirmation: 'cOmpl3x_p@55w0rd' }
        }

        expect(response).to redirect_to(root_path)
        expect(flash[:error]).to include('There is an open invitation')
        invited.reload
        expect(invited.invitation_accepted_at).to be_nil
      end
    end
  end
end
