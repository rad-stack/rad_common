require 'rails_helper'

RSpec.describe 'Companies', type: :system do
  let(:user) { create :admin }
  let(:company) { Company.main }

  before { login_as(user, scope: :user) }

  describe 'edit' do
    it 'renders the edit template' do
      visit edit_company_path(company)
      expect(page).to have_content('Editing Company')
    end
  end

  describe 'show' do
    it 'shows the company' do
      visit company_path(company)
      expect(page).to have_content(company.to_s)
    end
  end
end
