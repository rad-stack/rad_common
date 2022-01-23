require 'rails_helper'

RSpec.describe 'UserCustomers', type: :system do
  let(:user) { create :admin }
  let(:user_customer) { create :user_customer }

  before { login_as user, scope: :user }

  describe 'new' do
    it 'renders the new template' do
      visit new_user_user_customer_path(user)
      expect(page).to have_content("Adding Customer to #{user}")
    end
  end
end
