require 'rails_helper'

RSpec.describe 'States', type: :system do
  let(:user) { create :admin }
  let(:state) { create :state }

  before { login_as user, scope: :user }

  describe 'new' do
    it 'renders the new template' do
      visit new_state_path
      expect(page).to have_content('New State')
    end
  end

  describe 'edit' do
    it 'renders the edit template' do
      visit edit_state_path(state)
      expect(page).to have_content('Editing State')
    end
  end

  describe 'index' do
    it 'displays the states' do
      state
      visit states_path
      expect(page).to have_content(state.to_s)
    end
  end

  describe 'show' do
    it 'shows the state' do
      visit state_path(state)
      expect(page).to have_content(state.to_s)
    end
  end
end
