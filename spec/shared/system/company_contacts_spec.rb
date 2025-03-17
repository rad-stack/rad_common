require 'rails_helper'

RSpec.describe 'CompanyContacts' do
  describe 'new' do
    xit 'shows the information' do
      visit '/company_contacts/new'
      expect(page).to have_content(Company.main.name)
    end
  end
end
