require 'rails_helper'

RSpec.describe 'Companies', type: :system do
  let(:user) { create :admin }
  let(:company) { Company.main }

  before { login_as user, scope: :user }

  describe 'edit' do
    it 'renders the edit template' do
      visit '/rad_common/company/edit'
      expect(page).to have_content('Editing Company')
    end
  end

  describe 'show' do
    it 'shows the company' do
      visit '/rad_common/company'
      expect(page).to have_content(company.to_s)
    end
  end
end
