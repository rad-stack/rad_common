require 'rails_helper'

RSpec.describe 'SystemUsages', type: :system do
  let(:user) { create :admin }

  before do
    create_list :user, 4
    login_as user, scope: :user
  end

  describe 'index' do
    it 'displays the system usages' do
      visit '/rad_common/system_usages'
      expect(page).to have_content('5')
    end
  end
end
