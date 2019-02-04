require 'rails_helper'

describe 'AuditHistory', type: :request do
  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:division) { create :division }

  before do
    login_as(admin, scope: :user)
  end

  it 'shows the change in user history' do
    old_name = user.last_name
    new_name = 'foo'
    visit edit_user_path(user)
    fill_in 'First name', with: new_name
    click_button 'Save'

    click_link 'Show History'
    expect(page).to have_content new_name
    expect(page).to have_content old_name
  end

  it 'shows the change in division history' do
    old_name = division.name
    new_name = Faker::Name.first_name
    visit edit_division_path(division)
    fill_in 'Name', with: new_name
    click_button 'Save'

    click_link 'Show History'
    expect(page).to have_content new_name
    expect(page).to have_content old_name
  end

  it 'shows when the division was created in history' do
    visit new_division_path
    fill_in 'Name', with: 'Foo'
    fill_in 'Code', with: 'Bar'

    click_button 'Save'
    click_link 'Show History'
    expect(page).to have_content 'create'
    expect(page).to have_content 'Changed Name to Foo'
  end

  context 'audit by' do
    it 'shows audits for objects without show pages' do
      open_status = create :status, name: 'Open'

      Audited.audit_class.as_user(admin) do
        open_status.update(name: 'Foo')
      end

      visit "/users/#{admin.id}/audit_by"
      expect(page).to have_content 'Status - Foo'
    end

  end
end
