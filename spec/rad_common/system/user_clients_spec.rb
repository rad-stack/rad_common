require 'rails_helper'

RSpec.describe 'UserClients', type: :system, client_user_specs: true do
  let(:user) { create :admin }
  let(:user_client) { create :user_client }

  before { login_as user, scope: :user }

  describe 'new' do
    it 'renders the new template' do
      visit new_user_user_client_path(user)
      expect(page).to have_content(" to #{user}")
    end
  end
end
