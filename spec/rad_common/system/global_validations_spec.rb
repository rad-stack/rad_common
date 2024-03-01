require 'rails_helper'

RSpec.describe 'Companies', type: :system do
  let(:user) { create :admin }
  let(:result) { "We're checking the validity of your company's data." }

  before do
    login_as user, scope: :user
    Company.main.update_column :valid_user_domains, ['foo.com'] # trigger invalid data
    visit '/rad_common/global_validations/new'
  end

  context 'when full database' do
    it 'runs' do
      click_link 'Validate Full Database'
      expect(page).to have_content(result)
    end
  end

  context 'when single item' do
    it 'runs' do
      click_link 'Company'
      expect(page).to have_content(result)
    end
  end
end
