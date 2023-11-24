require 'rails_helper'

RSpec.describe 'Form Errors', type: :system do
  let!(:admin) { create :admin }
  let(:notification_type) { Notifications::InvalidDataWasFoundNotification.main }

  before do
    notification_type.security_roles.delete_all
    login_as admin, scope: :user
  end

  it 'displays base errors' do
    visit "/rad_common/notification_types/#{notification_type.id}/edit"
    click_button 'Save'
    expect(page).to have_content('invalid without security roles')
  end
end
