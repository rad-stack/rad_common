require 'rails_helper'

RSpec.describe 'SystemUsages', type: :system do
  let(:admin_role) { SecurityRole.find_by(admin: true).presence || create(:security_role, :admin) }
  let(:user) { create :admin, security_roles: [admin_role] }

  before do
    create_list :user, 4
    login_as user, scope: :user
  end

  describe 'index' do
    it 'displays the system usages' do
      visit '/system_usages'
      expect(page).to have_content('5')
    end
  end
end
