require 'rails_helper'

RSpec.describe 'CompanyContacts' do
  describe 'new' do
    it 'shows the information' do
      visit new_company_contact_path
      expect(page).to have_content(Company.main.name)
    end
  end
end
