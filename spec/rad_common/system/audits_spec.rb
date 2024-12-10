require 'rails_helper'

RSpec.describe 'Audits', type: :system do
  describe 'index' do
    let(:user) { create :admin }
    let(:new_name) { Faker::Company.name }
    let(:deleted_name) { Faker::Company.name }
    let(:security_role) { create :security_role, name: deleted_name }

    before { login_as user, scope: :user }

    it 'searches by record type' do
      security_role.update! name: new_name

      visit '/rad_common/audits'
      select 'SecurityRole', from: 'search_auditable_type'
      click_button 'Apply Filters'

      expect(page).to have_content new_name
    end

    it 'finds deleted audits' do
      security_role.destroy!

      visit '/rad_common/audits'
      select 'SecurityRole', from: 'search_auditable_type'
      click_button 'Apply Filters'

      expect(page).to have_content deleted_name
    end
  end
end
