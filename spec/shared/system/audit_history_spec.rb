require 'rails_helper'

RSpec.describe 'AuditHistory', type: :system do
  let(:admin) { create :admin }
  let(:user) { create :user }

  before { login_as admin, scope: :user }

  it 'shows the change in user history' do
    old_name = user.last_name
    new_name = 'foo'
    visit edit_user_path(user)
    fill_in 'First Name', with: new_name
    click_link_or_button 'Save'

    click_link_or_button 'Audit History'
    expect(page).to have_content new_name
    expect(page).to have_content old_name
  end

  it 'shows attachment created' do
    allow(RadConfig).to receive(:avatar?).and_return(true)

    visit edit_user_registration_path
    fill_in 'Current Password', with: 'cOmpl3x_p@55w0rd'
    page.attach_file('Avatar', 'spec/fixtures/test_photo.png')
    click_link_or_button 'Save'
    expect(page).to have_content 'account has been updated successfully'

    visit "/users/#{admin.id}"
    click_link_or_button 'Audit History'

    expect(page).to have_content 'create attachment'
  end

  it 'shows when the security role was created in history' do
    visit new_security_role_path
    fill_in 'Name', with: 'Foo'

    click_link_or_button 'Save'
    click_link_or_button 'Audit History'
    expect(page).to have_content 'create'
    expect(page).to have_content 'Changed Name to Foo'
  end
end
