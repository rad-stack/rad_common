require 'rails_helper'

describe 'Invitations', type: :system do
  let(:company) { Company.main }
  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:email_domain) { 'example.com' }
  let(:external_domain) { 'abc.com' }
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:valid_email) { Faker::Internet.user_name + '@' + email_domain }
  let(:external_email) { Faker::Internet.user_name + '@' + external_domain }

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
    before { login_as(admin, scope: :user) }

    describe 'new' do
      context 'when valid' do
        it 'invites a user', :vcr do
          visit new_user_invitation_path
          fill_in 'Email', with: valid_email
          fill_in 'First name', with: first_name
          fill_in 'Last name', with: last_name
          fill_in 'Mobile phone', with: '(999) 231-1111'
          click_button 'Send'
          expect(page).to have_content "We invited '#{first_name} #{last_name}'"
        end

        it 'invites an external user', :vcr do
          if RadCommon.external_users
            visit new_user_invitation_path
            fill_in 'Email', with: external_email
            fill_in 'First name', with: first_name
            fill_in 'Last name', with: last_name
            fill_in 'Mobile phone', with: '(999) 231-1111'
            check 'Client user?'
            click_button 'Send'
            expect(page).to have_content "We invited '#{first_name} #{last_name}'"
          end
        end
      end

      context 'when invalid' do
        it 'because of invalid email', :vcr do
          visit new_user_invitation_path
          bad_email = 'j@g.com'
          fill_in 'Email', with: bad_email
          fill_in 'First name', with: first_name
          fill_in 'Last name', with: last_name
          fill_in 'Mobile phone', with: '(999) 231-1111'
          click_button 'Send'
          expect(page).to have_content ' is not authorized for this application'
        end
      end
    end

    describe 'resend' do
      it 'resends invitation', :vcr do
        visit new_user_invitation_path
        fill_in 'Email', with: valid_email
        fill_in 'First name', with: first_name
        fill_in 'Last name', with: last_name
        fill_in 'Mobile phone', with: '(999) 231-1111'
        click_button 'Send'
        expect(page).to have_content "We invited '#{first_name} #{last_name}'"

        visit users_path
        click_link 'Resend Invitation'
        expect(page).to have_content 'We resent the invitation to the user.'
      end
    end
  end

  describe 'accept' do
    let!(:invitee) do
      User.invite!(email: Faker::Internet.user_name + '@' + email_domain,
                   first_name: Faker::Name.first_name,
                   last_name: Faker::Name.last_name,
                   mobile_phone: '(999) 231-1111')
    end

    it 'does not allow invitee to reset password after invite expires', :vcr do
      expect(invitee.errors.count).to eq(0)
      invitee.invitation_created_at = 3.weeks.ago
      invitee.invitation_sent_at = 3.weeks.ago
      invitee.save!

      visit new_user_password_path
      fill_in 'Email', with: invitee.email
      click_button 'Send Me Reset Password Instructions'
      expect(page).to have_content 'If your email address exists in our database, you will receive a password'
    end

    it 'notifies admin when invitee accepts', :vcr do
      ActionMailer::Base.deliveries = []
      create :user_accepts_invitation_notification, security_roles: [admin.security_roles.first]

      invitee.accept_invitation!

      mail = ActionMailer::Base.deliveries.last
      expect(mail.subject).to include 'Accepted'
      expect(mail.to).to include admin.email
    end

    it "doesn't let unaccepted invitee reset password", :vcr do
      ActionMailer::Base.deliveries = []

      visit new_user_password_path
      fill_in 'Email', with: invitee.email
      click_button 'Send Me Reset Password Instructions'
      expect(page).to have_content 'If your email address exists in our database, you will receive a password'

      expect(ActionMailer::Base.deliveries.count).to eq 0
    end
  end
end
