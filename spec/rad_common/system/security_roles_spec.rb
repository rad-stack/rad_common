require 'rails_helper'

RSpec.describe 'SecurityRoles', type: :system do
  let(:user) { create :admin }
  let(:security_role) { create :security_role }

  before { login_as user, scope: :user }

  describe 'new' do
    it 'renders the new template' do
      visit new_security_role_path
      expect(page).to have_content('New Security Role')
    end
  end

  describe 'edit' do
    it 'renders the edit template' do
      visit edit_security_role_path(security_role)
      expect(page).to have_content('Editing Security Role')
    end
  end

  describe 'index' do
    it 'displays the security_roles' do
      security_role
      visit security_roles_path
      expect(page).to have_content(security_role.to_s)
    end
  end

  describe 'show' do
    it 'shows the security_role' do
      visit security_role_path(security_role)
      expect(page).to have_content(security_role.to_s)
    end
  end
end
