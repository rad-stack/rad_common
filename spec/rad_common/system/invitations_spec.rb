require 'rails_helper'

RSpec.describe 'Invitations', type: :system, invite_specs: true do
  let(:company) { Company.main }
  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:email_domain) { 'example.com' }
  let(:external_domain) { 'abc.com' }
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:valid_email) { "#{Faker::Internet.user_name}@#{email_domain}" }
  let(:external_email) { "#{Faker::Internet.user_name}@#{external_domain}" }
  let!(:internal_role) { create :security_role, allow_invite: true }
  let!(:external_role) { create :security_role, :external, allow_invite: true }

  let(:invite_message) do
    if Devise.paranoid
      'If your email address exists in our database, you will receive a password'
    else
      'not found'
    end
  end

  before { allow_any_instance_of(User).to receive(:twilio_verify_enabled?).and_return false }

  describe 'user' do
    before { login_as user, scope: :user }

    describe 'new' do
      it 'does not allow' do
        visit new_user_invitation_path
        expect(page).to have_content 'Access Denied'
      end
    end
  end

  describe 'admin' do
    before { login_as admin, scope: :user }

    describe 'new' do
      context 'when valid' do
        it 'invites a user' do
          visit new_user_invitation_path

          select internal_role.name, from: 'Initial security role'
          fill_in 'Email', with: valid_email
          fill_in 'First name', with: first_name
          fill_in 'Last name', with: last_name
          fill_in 'Mobile phone', with: '(999) 231-1111'
          click_button 'Send'

          expect(page).to have_content "We invited '#{first_name} #{last_name}'"
          expect(User.last.security_roles.first).to eq internal_role
          expect(User.last.internal?).to be true
        end

        it 'invites an external user', external_user_specs: true do
          visit new_user_invitation_path

          select external_role.name, from: 'Initial security role'
          fill_in 'Email', with: external_email
          fill_in 'First name', with: first_name
          fill_in 'Last name', with: last_name
          fill_in 'Mobile phone', with: '(999) 231-1111'
          click_button 'Send'

          expect(page).to have_content "We invited '#{first_name} #{last_name}'"
          expect(User.last.security_roles.first).to eq external_role
          expect(User.last.external?).to be true
        end

        it 'invites an external user and sets initial role', external_user_specs: true do
          create :security_role, :external, allow_invite: true
          initial_role = create :security_role, :external, allow_invite: true

          visit new_user_invitation_path

          select initial_role.name, from: 'Initial security role'
          fill_in 'Email', with: external_email
          fill_in 'First name', with: first_name
          fill_in 'Last name', with: last_name
          fill_in 'Mobile phone', with: '(999) 231-1111'
          click_button 'Send'

          expect(page).to have_content "We invited '#{first_name} #{last_name}'"
          expect(User.last.security_roles.first).to eq initial_role
        end
      end

      context 'when invalid' do
        xit 'because of blank email' do
          # TODO: waiting on bug fix in devise-security, see Task 35144
          visit new_user_invitation_path

          fill_in 'First name', with: first_name
          fill_in 'Last name', with: last_name
          click_button 'Send an invitation'

          expect(page).to have_content "Email can't be blank"
        end

        it 'because of blank first and last name' do
          visit new_user_invitation_path

          fill_in 'user_email', with: external_email
          click_button 'Send an invitation'

          expect(page).to have_content "First name can't be blank"
          expect(page).to have_content "Last name can't be blank"
        end

        it 'because of invalid email' do
          visit new_user_invitation_path

          bad_email = 'j@g.com'
          fill_in 'Email', with: bad_email
          fill_in 'First name', with: first_name
          fill_in 'Last name', with: last_name
          fill_in 'Mobile phone', with: '(999) 231-1111'
          click_button 'Send an invitation'

          expect(page).to have_content ' is not authorized for this application'
        end

        it 'because of a single letter in name that conflicts with password in name validation' do
          visit new_user_invitation_path

          fill_in 'Email', with: valid_email
          fill_in 'First name', with: 'f'
          fill_in 'Last name', with: 'b'
          fill_in 'Mobile phone', with: '(999) 231-1111'
          click_button 'Send an invitation'

          expect(page).to have_content "We invited 'f b'"
        end
      end
    end

    describe 'resend' do
      it 'resends invitation' do
        visit new_user_invitation_path

        fill_in 'Email', with: valid_email
        fill_in 'First name', with: first_name
        fill_in 'Last name', with: last_name
        fill_in 'Mobile phone', with: '(999) 231-1111'
        click_button 'Send'

        expect(page).to have_content "We invited '#{first_name} #{last_name}'"

        visit user_path(User.last)
        click_link 'Resend Invitation'
        expect(page).to have_content 'We resent the invitation to the user.'
      end
    end
  end

  describe 'accept' do
    let!(:invitee) do
      User.invite!(email: "#{Faker::Internet.user_name}@#{email_domain}",
                   first_name: Faker::Name.first_name,
                   last_name: Faker::Name.last_name,
                   mobile_phone: create(:phone_number, :mobile),
                   initial_security_role_id: internal_role.id)
    end

    it 'does not allow invitee to reset password after invite expires' do
      expect(invitee.errors.count).to eq(0)
      invitee.invitation_created_at = 3.weeks.ago
      invitee.invitation_sent_at = 3.weeks.ago
      invitee.save!

      visit new_user_password_path
      fill_in 'Email', with: invitee.email
      click_button 'Send Me Reset Password Instructions'
      expect(page).to have_content invite_message
    end

    it 'notifies admin when invitee accepts' do
      ActionMailer::Base.deliveries = []
      create :user_accepts_invitation_notification, security_roles: [admin.security_roles.first]

      invitee.accept_invitation!

      mail = ActionMailer::Base.deliveries.last
      expect(mail.subject).to include 'Accepted'
      expect(mail.to).to include admin.email
    end

    it "doesn't let unaccepted invitee reset password" do
      ActionMailer::Base.deliveries = []

      visit new_user_password_path
      fill_in 'Email', with: invitee.email
      click_button 'Send Me Reset Password Instructions'
      expect(page).to have_content invite_message

      expect(ActionMailer::Base.deliveries.count).to eq 0
    end
  end
end
