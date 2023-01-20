require 'rails_helper'

RSpec.describe 'ContactUs', type: :system do
  describe 'contact_us' do
    it 'shows the information' do
      visit '/new_contact_us'
      expect(page).to have_content(Company.main.name)
    end
  end
end
