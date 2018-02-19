require 'rails_helper'

RSpec.describe 'Companies', type: :request do
  let(:user) { create :admin }
  let(:company) { Company.main }

  before do
    login_as(user, scope: :user)
  end

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
