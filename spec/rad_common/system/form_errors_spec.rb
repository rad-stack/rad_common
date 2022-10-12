require 'rails_helper'

RSpec.describe 'Form Errors', type: :system do
  let(:admin) { create :admin }
  let(:user) { create :user }

  before do
    user.update_column :authy_id, '100'
    user.update_column :authy_enabled, false

    login_as admin, scope: :user
  end

  it 'displays base errors' do
    visit "/users/#{user.id}/edit"
    select '(GMT-07:00) Mountain Time (US & Canada)', from: 'Timezone'
    click_button 'Save'
    expect(page).to have_content('user is not valid for two factor authentication')
  end
end
