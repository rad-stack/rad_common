require 'rails_helper'

RSpec.describe 'User Impersonation', :impersonate_specs, type: :system do
  let!(:signed_in_user) { create :admin }
  let!(:impersonated_user) { create :admin }
  let!(:edited_user) { create :user }

  before { login_as signed_in_user }

  context 'with an internal user' do
    it 'allows an admin to impersonate, but keeps audits as original user', :gha_specs_only, :js do
      visit users_path(search: { user_status_id: nil, external: 'internal' })
      click_on impersonated_user.to_s
      accept_confirm { click_on 'Sign In As' }
      expect(page).to have_content "Signed In as #{impersonated_user}"
      visit edit_user_path(edited_user)

      fill_in 'First name', with: 'Foo Bro'
      click_button 'Save'
      click_on 'Show History'

      within '.card-body' do
        attribution = find('td', text: signed_in_user.to_s)
        expect(attribution).not_to be_blank
      end

      click_on "Signed In as #{impersonated_user}"
      click_on "Sign Out from #{impersonated_user}"
      expect(page).to have_content signed_in_user.to_s
    end

    it 'is not allowed for users without the proper permission', :gha_specs_only, :js do
      visit user_path(signed_in_user)
      expect(page).to have_no_content 'Sign In As'

      visit user_path(impersonated_user)
      expect(page).to have_content 'Sign In As'

      impersonated_user.update! user_status: create(:user_status, :inactive)

      visit user_path(impersonated_user)
      expect(page).to have_no_content 'Sign In As'
    end
  end
end
