require 'rails_helper'

RSpec.describe 'LoginActivities', type: :system do
  let(:user) { create :admin }

  before { login_as user, scope: :user }

  describe 'index' do
    it 'displays the login activities' do
      visit '/rad_common/login_activities'
      expect(page).to have_content(user.email)
    end

    it 'does not warn on leaving page when filling out search field', js: true do
      visit '/rad_common/login_activities?search%5Bcreated_at_start%5D=2020-11-11&search%5Bcreated_at_end%5D=2020-11-11'
      find('body').click
      visit '/'

      expect(confirm_present?).to eq false
    end
  end
end
