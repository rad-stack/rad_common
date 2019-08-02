require 'rails_helper'

describe 'Divisions', type: :request do
  let(:division) { create :division }

  it 'displays error for owner field when blank', js: true do
    visit edit_division_path(division)
    find(:css, 'input[name=owner_name]').set('')
    click_button 'Save'
    expect(page).to have_content 'must exist and can\'t be blank'
  end
end
