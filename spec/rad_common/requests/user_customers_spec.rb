require 'rails_helper'

RSpec.describe 'UserCustomers', type: :request do
  let(:admin) { create :admin }
  let(:user) { create :user, :external }
  let(:customer_user) { create :customer_user, customer: customer }
  let(:user_customer) { customer_user.user_customers.first }
  let(:customer) { create :customer }
  let(:valid_attributes) { { customer_id: customer.id, user_id: user.id } }
  let(:invalid_attributes) { { customer_id: nil, user_id: customer_user.id } }

  before { login_as admin, scope: :user }

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new UserCustomer' do
        expect {
          post '/user_customers/', params: { user_customer: valid_attributes }
        }.to change(UserCustomer, :count).by(1)
      end

      it 'redirects to the user' do
        post '/user_customers/', params: { user_customer: valid_attributes }
        expect(response).to redirect_to(UserCustomer.last.user)
      end
    end

    describe 'with invalid params' do
      it 're-renders the new template' do
        post '/user_customers/', params: { user_customer: invalid_attributes }
        expect(response.body).to include 'Please review the problems below'
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      create :user_customer, user: user_customer.user
    end

    it 'destroys the requested user_customer' do
      user_customer
      expect {
        delete "/user_customers/#{user_customer.id}"
      }.to change(UserCustomer, :count).by(-1)
    end

    it 'redirects to the user' do
      delete "/user_customers/#{user_customer.id}"
      expect(response).to redirect_to(user_customer.user)
    end
  end
end
