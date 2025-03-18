require 'rails_helper'

describe UserClient, type: :model, user_client_specs: true do
  let(:client) { create :client }
  let(:user_client) { build :user_client, user: user, client: client }

  describe '#destroy' do
    let(:user) { create :user }

    before { client.update! valid_user_domains: %w[radbear.net] }

    it 'succeeds if last client' do
      user_client.save! validate: false

      user_client.destroy
      expect(user_client).to be_destroyed
    end
  end

  describe 'validate email' do
    it 'rejects invalid email addresses' do
      addresses = %w[user@bar.com user@foo.com]

      addresses.each do |address|
        user = create :user, :external, email: address
        user_client = described_class.new(user: user, client: client)

        if RadConfig.validate_external_email_domain?
          expect(user_client).not_to be_valid
          expect(user_client.errors.full_messages.to_s).to include 'Client is not valid for this email user'
        else
          expect(user_client).to be_valid
        end
      end
    end
  end

  describe 'validate' do
    context 'with internal user' do
      let(:user) { create :user }

      before { client.update! valid_user_domains: %w[radbear.net] }

      it 'rejects internal users' do
        expect(user_client).not_to be_valid
        expect(user_client.errors.full_messages.to_s).to include 'User is not valid when internal'
      end
    end
  end
end
