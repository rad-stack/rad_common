require 'rails_helper'

describe 'AuditHistory', type: :system do
  let(:admin) { create :admin }
  let(:user) { create :user }

  before { login_as admin, scope: :user }

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

  it 'shows attachment created' do
    visit '/users/edit'
    page.attach_file('Avatar', 'spec/test_files/radlogo.png')
    click_on 'Save'

    visit "/users/#{admin.id}"
    click_on 'Show History'
    expect(page).to have_content 'create attachment'
  end

  it 'shows when the security role was created in history' do
    visit new_security_role_path
    fill_in 'Name', with: 'Foo'

    click_button 'Save'
    click_link 'Show History'
    expect(page).to have_content 'create'
    expect(page).to have_content 'Changed Name to Foo'
  end

  describe 'audit by' do
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
