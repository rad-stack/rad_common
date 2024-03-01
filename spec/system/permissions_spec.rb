require 'rails_helper'

describe 'Permissions' do
  let(:user) { create :user, security_roles: [security_role] }
  let(:security_role) { create :security_role, read_division: true }
  let(:division) { create :division }

  before { login_as user, scope: :user }

  it 'updates the ui when changed', :js do
    visit "/divisions/#{division.id}"
    expect(page).not_to have_content 'Delete'

    user.security_roles.update_all delete_division: true

    visit "/divisions/#{division.id}"
    expect(page).to have_content 'Delete'
  end
end
