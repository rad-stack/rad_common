require 'rails_helper'

RSpec.describe 'AreYouSure', type: :system do
  let(:user) { create :admin }

  before { login_as user, scope: :user }

  describe 'global super search field' do
    it 'does not warn', :js do
      visit '/'
      fill_in 'global_search_name', with: 'test'
      find('body').click
      visit current_path

      expect(confirm_present?).to be false
    end
  end

  describe 'search filter form fields' do
    it 'does not warn', :js do
      visit '/rad_common/login_activities?search%5Bcreated_at_start%5D=2020-11-11&search%5Bcreated_at_end%5D=2020-11-11'
      find('body').click
      visit '/'

      expect(confirm_present?).to be false
    end
  end
end
