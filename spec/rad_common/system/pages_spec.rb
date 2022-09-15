require 'rails_helper'

RSpec.describe 'Pages', type: :system do
  let(:user) { create :admin }

  before { login_as user, scope: :user }

  describe 'terms', sign_up_specs: true do
    it 'shows the information' do
      visit terms_path
      expect(page).to have_content(RadicalConfig.app_name!)
    end
  end
end
