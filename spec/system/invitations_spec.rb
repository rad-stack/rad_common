require 'rails_helper'

RSpec.describe 'Invitations', :invite_specs, type: :system do
  let(:company) { Company.main }
  let(:admin) { create :admin, twilio_verify_enabled: true } # TODO: can this arg be removed when done?
  let(:user) { create :user }
  let(:email_domain) { 'example.com' }
  let(:external_domain) { 'abc.com' }
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:name_display) { RadConfig.last_first_user? ? "#{last_name}, #{first_name}" : "#{first_name} #{last_name}" }
  let(:valid_email) { "#{Faker::Internet.user_name}@#{email_domain}" }
  let(:external_email) { "#{Faker::Internet.user_name}@#{external_domain}" }
  let!(:admin_role) { create :security_role, :admin, allow_invite: true }
  let!(:internal_role) { create :security_role, allow_invite: true }
  let!(:external_role) { create :security_role, :external, allow_invite: true }
  let(:open_invite_error) { "There is an open invitation for this user: #{invitee.email}" }
  let(:another_role) { create :security_role, :external, allow_invite: true }
  let(:multiple_roles) { false }
  let(:all_users) { true }

  before do
    allow(RadConfig).to receive(:twilio_verify_all_users?).and_return(false)

    login_as admin, scope: :user

    if multiple_roles
      another_role
      create :security_role, :external, allow_invite: true
    end

    visit new_user_invitation_path

    select invite_role.name, from: 'Initial Security Role'
    fill_in 'Email', with: invite_email
    fill_in 'First Name', with: first_name
    fill_in 'Last Name', with: last_name
    fill_in 'Mobile Phone', with: '(999) 231-1111'
    click_button 'Send'

    expect(page).to have_content "We invited '#{name_display}'"
    expect(User.last.security_roles.first).to eq invite_role
    expect(User.last.user_status.active?).to be true
  end

  let(:invite_role) { admin_role }
  let(:invite_email) { valid_email }

  it 'invites' do
    expect(User.last.internal?).to be true
    expect(User.last.twilio_verify_enabled?).to be true
  end
end
