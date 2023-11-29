require 'rails_helper'

describe 'Nav' do
  let(:attorney) { create :attorney }

  let(:duplicate_attorney) do
    create :attorney,
           first_name: attorney.first_name,
           last_name: attorney.last_name,
           address_1: attorney.address_1,
           city: attorney.city,
           state: attorney.state,
           zipcode: attorney.zipcode,
           phone_number: attorney.phone_number,
           email: attorney.email
  end

  before do
    allow_any_instance_of(Duplicate).to receive :maybe_notify_duplicates

    attorney
    duplicate_attorney

    attorney.process_duplicates
    duplicate_attorney.process_duplicates

    login_as user, scope: :user
  end

  context 'with admin' do
    let(:user) { create :admin }

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

  context 'with user' do
    let(:user) { create :user }

    it 'shows the menu' do
      visit root_path
      expect(page).to have_content 'Clients'
    end
  end
end