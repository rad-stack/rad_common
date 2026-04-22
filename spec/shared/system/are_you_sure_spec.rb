require 'rails_helper'

RSpec.describe 'AreYouSure', type: :system do
  let(:user) { create :admin }

  before { login_as user, scope: :user }

  describe 'normal form fields' do
    it 'warns', :js do
      visit '/company/edit'
      fill_in 'company_name', with: 'test'
      find('body').click

      expect(page).to have_css('.simple_form.dirty')
    end
  end

  describe 'rich text fields' do
    it 'warns', :js do
      visit '/system_messages/new'
      find('trix-editor').set('test')
      find('body').click

      expect(page).to have_css('.simple_form.dirty')
    end
  end

  describe 'global super search field' do
    it 'does not warn', :js, :legacy_asset_specs do
      visit '/'
      tom_search 'test', from: 'search'
      find('body').click

      expect(page).to have_no_css('.simple_form.dirty')
    end
  end

  describe 'search filter form fields' do
    it 'does not warn', :js do
      visit '/login_activities?search%5Bcreated_at_start%5D=2020-11-11&search%5Bcreated_at_end%5D=2020-11-11'
      find('body').click

      expect(page).to have_no_css('.simple_form.dirty')
    end
  end
end
