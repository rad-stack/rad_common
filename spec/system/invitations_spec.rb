require 'rails_helper'

RSpec.describe 'Invitations' do
  let(:admin) { create :admin, security_roles: [admin_role] }
  let(:signed_in_user) { admin }
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:name_display) { RadConfig.last_first_user? ? "#{last_name}, #{first_name}" : "#{first_name} #{last_name}" }
  let(:invite_email) { "#{Faker::Internet.user_name}@example.com" }
  let(:admin_role) { create :security_role, :admin, allow_invite: true }

  before do
    create :security_role, allow_invite: true
    login_as signed_in_user, scope: :user
  end

  context 'when twilio_verify_all_users is disabled' do
    before { allow(RadConfig).to receive(:twilio_verify_all_users?).and_return(false) }

    it 'invites an admin and enabled two factor auth' do
      visit new_user_invitation_path

      select admin_role.name, from: 'Initial Security Role'
      fill_in 'Email', with: invite_email
      fill_in 'First Name', with: first_name
      fill_in 'Last Name', with: last_name
      fill_in 'Mobile Phone', with: '(999) 231-1111'
      click_on 'Send'

      expect(page).to have_content "We invited '#{name_display}'"
      expect(User.last.security_roles.first).to eq admin_role
      expect(User.last.twilio_verify_enabled?).to be true
    end
  end

  context 'when invited by is external and invitee is internal' do
    let(:signed_in_user) { create :user, :external, security_roles: [external_role] }
    let(:external_role) { create :security_role, allow_invite: true, external: true }
    let(:another_external_role) { create :security_role, allow_invite: true, external: true }

    before do
      create :security_role, allow_invite: true
      signed_in_user.security_roles.first.update! manage_user: true
      external_role
    end

    it "doesn't allow the invite" do
      SecurityRole.update_all external: true
      visit new_user_invitation_path
      SecurityRole.update_all external: false

      select external_role.name, from: 'Initial Security Role'
      fill_in 'Email', with: invite_email
      fill_in 'First Name', with: first_name
      fill_in 'Last Name', with: last_name
      fill_in 'Mobile Phone', with: '(999) 231-1111'
      click_on 'Send'

      expect(page).to have_content 'Initial security role cannot be internal'
    end
  end
end
