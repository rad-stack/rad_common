require 'rails_helper'

RSpec.describe 'Divisions' do
  let(:user) { create :admin }

  before { login_as user, scope: :user }

  it 'loads validations when new form renders' do
    visit new_division_path
    expect(page).to have_css '.string.required'
  end

  it 'loads validations when edit form renders' do
    Object.send(:remove_const, :Division)
    load 'division.rb'
    Division.schema_validations_loaded = true
    division = create :division
    Division.schema_validations_loaded = false
    visit edit_division_path(division)
    expect(page).to have_css '.string.required'
  end
end
