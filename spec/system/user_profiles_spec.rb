require 'rails_helper'

RSpec.describe 'UserProfiles', type: :system do
  let(:user) { create :user_with_profile }

  before { login_as user, scope: :user }

  describe 'edit' do
    it 'renders the edit template' do
      visit edit_user_profile_path(user)
      expect(page).to have_content('Editing My Profile')
    end
  end

  describe 'show' do
    it 'shows the user_profile' do
      visit user_profile_path(user)
      expect(page).to have_content('My Profile')
    end
  end
end
