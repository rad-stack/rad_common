require 'rails_helper'

RSpec.describe 'UserProfiles' do
  before { login_as user, scope: :user }

  describe 'edit' do
    let(:user) { create :user }

    it 'renders the edit template' do
      visit edit_user_profile_path(user)
      expect(page).to have_content('Please Enter Your Profile')
    end

    it 'requires completing the profile' do
      visit edit_user_profile_path(user)
      click_button 'Save'
      expect(page).to have_content("Birth date can't be blank")
    end
  end

  describe 'show' do
    let(:user) { create :user_with_profile }

    it 'shows the user_profile' do
      visit user_profile_path(user)
      expect(page).to have_content('My Profile')
    end
  end
end
