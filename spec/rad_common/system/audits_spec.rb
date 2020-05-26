require 'rails_helper'

describe 'Audits', type: :system do
  describe 'index' do
    let(:user) { create :admin }
    let(:division) { create :division }
    let(:new_name) { Faker::Company.name }
    let(:deleted_name) { Faker::Company.name }
    let(:security_role) { create :security_role, name: deleted_name }

    before do
      division.update! name: new_name
      security_role.destroy!

      login_as user, scope: :user
    end

    it 'searches by record type' do
      visit '/rad_common/audits'
      select 'Division', from: 'search_auditable_type'
      click_button 'Apply Filters'

      expect(page).to have_content new_name
    end

    it 'finds deleted audits' do
      visit '/rad_common/audits'
      select 'SecurityRole', from: 'search_auditable_type'
      click_button 'Apply Filters'

      expect(page).to have_content deleted_name
    end
  end
end
