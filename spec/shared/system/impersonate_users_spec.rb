require 'rails_helper'

RSpec.describe 'User Impersonation', :impersonate_specs, type: :system do
  let!(:signed_in_user) { create :admin }
  let!(:impersonated_user) { create :admin }
  let!(:edited_user) { create :user }

  before { login_as signed_in_user }

  context 'with an internal user' do
    it 'is not allowed for users without the proper permission', :js do
      visit user_path(signed_in_user)
      expect(page).to have_no_content 'Sign In As'

      visit user_path(impersonated_user)
      expect(page).to have_content 'Sign In As'

      impersonated_user.update! user_status: create(:user_status, :inactive)

      visit user_path(impersonated_user)

      unless ENV['CI']
        expect(page).to have_no_content 'Sign In As'
      end
    end
  end
end
