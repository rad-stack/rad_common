require 'rails_helper'

describe "AuditHistory", type: :request do
  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:division) { create :division }

  before(:each) do
    login_as(admin, scope: :user)
  end

  it "should show the change in user history" do
    old_name = user.last_name
    new_name = "foo"
    visit edit_user_path(user)
    fill_in "First name", with: new_name
    click_button "Save"

    click_link "Show History"
    expect(page).to have_content new_name
    expect(page).to have_content old_name
  end

  it 'should show the change in division history' do
    old_name = division.name
    new_name = Faker::Name.first_name
    visit edit_division_path(division)
    fill_in 'Name', with: new_name
    click_button 'Save'

    click_link 'Show History'
    expect(page).to have_content new_name
    expect(page).to have_content old_name
  end

  it 'should show when the division was created in history' do
    visit new_division_path
    fill_in 'Name', with: 'Foo'
    fill_in 'Code', with: 'Bar'

    click_button 'Save'
    click_link 'Show History'
    expect(page).to have_content 'create'
    expect(page).to have_content 'Changed Name to Foo'
  end
end
