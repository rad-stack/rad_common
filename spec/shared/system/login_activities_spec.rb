require 'rails_helper'

RSpec.describe 'LoginActivities', type: :system do
  let(:user) { create :admin }

  before { login_as user, scope: :user }

  describe 'index' do
    it 'displays the login activities' do
      visit '/login_activities'
      expect(page).to have_content(user.email)
    end
  end
end
