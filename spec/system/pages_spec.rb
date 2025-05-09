require 'rails_helper'

RSpec.describe 'Pages' do
  let(:user) { create :admin }

  before { login_as user, scope: :user }

  describe 'terms' do
    it 'shows the information' do
      visit terms_path
      expect(page).to have_content('Terms and Conditions')
      expect(page).to have_content(RadConfig.app_name!)
    end
  end

  describe 'privacy' do
    it 'shows the information' do
      visit privacy_path
      expect(page).to have_content('Privacy Policy')
      expect(page).to have_content(RadConfig.app_name!)
    end
  end
end
