require 'rails_helper'

RSpec.describe 'Pages', type: :system do
  let(:user) { create :admin }

  before { login_as user, scope: :user }

  describe 'contact_us' do
    it 'shows the information' do
      visit contact_us_path
      expect(page).to have_content(Company.main.name)
    end
  end
end
