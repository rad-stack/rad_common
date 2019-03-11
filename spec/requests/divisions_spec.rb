require 'rails_helper'

RSpec.describe 'Divisions', type: :request do
  let(:user) { create :admin }
  let(:division) { create :division }

  before do
    login_as(user, scope: :user)
  end

  describe 'new' do
    it 'renders the new template' do
      visit new_division_path
      expect(page).to have_content('New Division')
    end
  end

  describe 'edit' do
    it 'renders the edit template' do
      visit edit_division_path(division)
      expect(page).to have_content('Editing Division')
    end
  end

  describe 'index' do
    it 'displays the divisions' do
      division
      visit divisions_path
      expect(page).to have_content(division.to_s)
    end
  end

  describe 'show' do
    before { visit division_path(division) }

    it 'shows the division' do
      expect(page).to have_content(division.to_s)
    end

    it 'shows the right actions' do
      expect(page).to have_content('Right Button')
    end
  end
end
