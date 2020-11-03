require 'rails_helper'

describe 'Users', type: :system do
  let(:user) { create :user }
  let(:admin) { create :admin }

  describe 'edit' do
    before do
      login_as admin, scope: :user
      visit edit_user_path(user)
    end

    context 'when dynamically changing fields', js: true do
      it 'hides internal fields if client user is checked' do
        find_field('user_external').set(false)
        expect(page).to have_content 'Security roles'
      end

      it 'shows internal fields if client user is not checked' do
        find_field('user_external').set(true)
        expect(page).not_to have_content 'Security roles'
      end
    end
  end
end
