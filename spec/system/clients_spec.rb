require 'rails_helper'

RSpec.describe 'Clients' do
  let(:user) { create :admin }
  let(:client) { create :client }

  before { login_as user, scope: :user }

  describe 'new' do
    it 'renders the new template' do
      visit new_client_path
      expect(page).to have_content('New Client')
    end
  end

  describe 'edit' do
    it 'renders the edit template' do
      visit edit_client_path(client)
      expect(page).to have_content('Editing Client')
    end
  end

  describe 'index' do
    it 'displays the clients' do
      client
      visit clients_path
      expect(page).to have_content(client.to_s)
    end
  end

  describe 'show' do
    it 'shows the client' do
      visit client_path(client)
      expect(page).to have_content(client.to_s)
    end
  end
end
