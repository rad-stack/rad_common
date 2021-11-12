require 'rails_helper'

describe 'Users', type: :system do
  let!(:internal_role) { create :security_role }
  let!(:external_role) { create :security_role, :external }

  let(:user) { create :user, security_roles: [internal_role] }
  let(:admin) { create :admin }

  describe 'edit' do
    before do
      login_as admin, scope: :user
      visit edit_user_path(user)
    end

    context 'when dynamically changing fields', js: true do
      it 'shows internal roles and hides others' do
        find_field('user_external').set(false)
        expect(page).to have_content 'Security roles'
        expect(page).to have_content internal_role.name
      end

      it 'shows external roles and hides others' do
        find_field('user_external').set(true)
        expect(page).to have_content 'Security roles'
        expect(page).to have_content external_role.name
      end
    end
  end
end
