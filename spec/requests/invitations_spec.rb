require 'rails_helper'

describe 'Invitations', type: :request do
  let!(:admin) { create :admin }
  let(:user) { create :user }
  let(:email_domain) { 'example.com' }
  let(:external_domain) { 'abc.com' }
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:valid_email) { Faker::Internet.user_name + '@' + email_domain }
  let(:external_email) { Faker::Internet.user_name + '@' + external_domain }

  describe 'user' do
    before do
      login_as(user, scope: :user)
    end

    describe 'new' do
      it 'does not allow' do
        visit new_user_invitation_path
        expect(page).to have_content 'Access Denied'
      end
    end
  end

  describe 'admin' do
    before do
      login_as(admin, scope: :user)
    end

    describe 'new' do
      context 'valid' do
        it 'invites a user' do
          visit new_user_invitation_path
          fill_in 'Email', with: valid_email
          fill_in 'First name', with: first_name
          fill_in 'Last name', with: last_name
          click_button 'Send'
          expect(page).to have_content "We invited '#{first_name} #{last_name}'"
        end

        it 'invites an external user' do
          visit new_user_invitation_path
          fill_in 'Email', with: external_email
          fill_in 'First name', with: first_name
          fill_in 'Last name', with: last_name
          check 'External user?'
          click_button 'Send'
          expect(page).to have_content "We invited '#{first_name} #{last_name}'"
        end
      end

      context 'invalid' do
        it 'because of invalid email' do
          visit new_user_invitation_path
          bad_email = 'j@g.com'
          fill_in 'Email', with: bad_email
          fill_in 'First name', with: first_name
          fill_in 'Last name', with: last_name
          click_button 'Send'
          expect(page).to have_content ' is not authorized for this application'
        end
      end
    end

    describe 'resend' do
      it 'resends invitation' do
        visit new_user_invitation_path
        fill_in 'Email', with: valid_email
        fill_in 'First name', with: first_name
        fill_in 'Last name', with: last_name
        click_button 'Send'
        expect(page).to have_content "We invited '#{first_name} #{last_name}'"

        visit users_path
        click_link 'Resend Invitation'
        expect(page).to have_content 'We resent the invitation to the user.'
      end
    end
  end

  describe 'accept' do
    before do
      @invitee = User.invite!(email: Faker::Internet.user_name + '@' + email_domain,
                              first_name: Faker::Name.first_name,
                              last_name: Faker::Name.last_name)
    end

    it 'does not allow invitee to reset password after invite expires' do
      @invitee = User.find(@invitee.id)
      expect(@invitee.errors.count).to eq(0)
      @invitee.invitation_created_at = 3.weeks.ago
      @invitee.invitation_sent_at = 3.weeks.ago
      @invitee.save!

      visit new_user_password_path
      fill_in 'Email', with: @invitee.email
      click_button 'Send Me Reset Password Instructions'
      expect(page).to have_content 'not found'
    end

    it 'notifies admin when invitee accepts' do
      ActionMailer::Base.deliveries = []

      @invitee.accept_invitation!

      mail = ActionMailer::Base.deliveries.last
      expect(mail.subject).to include 'Accepted'
      expect(mail.to).to include admin.email
    end

    it "doesn't let unaccepted invitee reset password" do
      ActionMailer::Base.deliveries = []

      visit new_user_password_path
      fill_in 'Email', with: @invitee.email
      click_button 'Send Me Reset Password Instructions'
      expect(page).to have_content 'not found'

      expect(ActionMailer::Base.deliveries.count).to eq 0
    end
  end
end
