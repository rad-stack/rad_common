require 'rails_helper'

describe 'Nav' do
  let(:user) { create :admin }
  let(:attorney) { create :attorney }

  before do
    allow_any_instance_of(Duplicate).to receive :maybe_notify_duplicates

    create :attorney,
           first_name: attorney.first_name,
           last_name: attorney.last_name,
           address_1: attorney.address_1,
           city: attorney.city,
           state: attorney.state,
           zipcode: attorney.zipcode,
           phone_number: attorney.phone_number,
           email: attorney.email

    attorney.process_duplicates

    login_as user, scope: :user
  end

  it 'shows the menu' do
    visit root_path
    expect(page).to have_content 'Clients'
  end

  context 'with users on admin menu' do
    before { allow_any_instance_of(RadNav::AdminMenu).to receive(:include_users).and_return(true) }

    it 'shows the menu' do
      visit root_path
      expect(page).to have_content 'Clients'
    end
  end
end
