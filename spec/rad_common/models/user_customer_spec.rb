require 'rails_helper'

describe UserCustomer, type: :model do
  let(:customer) { create :customer }

  describe '#destroy' do
    let(:user) { create :user }
    let(:user_customer) { build :user_customer, user: user, customer: customer }

    before { customer.update! valid_user_domains: %w[radbear.net] }

    it 'succeeds if last customer' do
      user_customer.save! validate: false

      user_customer.destroy
      expect(user_customer).to be_destroyed
    end
  end

  describe 'validate email' do
    it 'rejects invalid email addresses' do
      addresses = %w[user@bar.com user@foo.com]

      addresses.each do |address|
        user = create :user, :external, email: address
        user_customer = described_class.new(user: user, customer: customer)
        expect(user_customer).not_to be_valid
        expect(user_customer.errors.full_messages.to_s).to include 'Customer is not valid for this email user'
      end
    end
  end

  describe 'validate' do
    let(:user_customer) { build :user_customer, user: user }

    context 'with internal user' do
      let(:user) { create :user }

      before { customer.update! valid_user_domains: %w[radbear.net] }

      it 'rejects internal users' do
        expect(user_customer).not_to be_valid
        expect(user_customer.errors.full_messages.to_s).to include 'User is not valid when internal'
      end
    end
  end
end
