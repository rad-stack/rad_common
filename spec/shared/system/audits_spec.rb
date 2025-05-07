require 'rails_helper'

RSpec.describe 'Audits', type: :system do
  describe 'index' do
    let(:user) { create :admin }
    let(:new_name) { Faker::Company.name }
    let(:deleted_name) { Faker::Company.name }
    let(:security_role) { create :security_role, name: deleted_name }

    before { login_as user, scope: :user }

    xit 'searches by record type' do
      security_role.update! name: new_name

      visit '/audits'
      first('#search_auditable_type').select('SecurityRole')
      first('button', text: 'Apply Filters').click

      expect(page).to have_content new_name
    end

    xit 'finds deleted audits' do
      security_role.destroy!

      visit '/audits'
      first('#search_auditable_type').select('SecurityRole')
      first('button', text: 'Apply Filters').click

      expect(page).to have_content deleted_name
    end
  end
end
