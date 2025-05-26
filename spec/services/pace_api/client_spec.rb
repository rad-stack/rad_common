require 'rails_helper'

RSpec.describe PaceApi::Client, type: :service do
  let(:client) { described_class.new }
  let(:house_customer) { client.read_object('Customer', 'HOUSE') }

  describe '#read_object' do
    it 'reads an object', :vcr do
      expect(house_customer['custName']).to eq('Profitable Printing Company')
    end
  end

  describe '#update_object' do
    it 'updates an object', :vcr do
      house_customer['customerLegalName'] = 'Updated Name'
      client.update_object('Customer', house_customer)
      updated_customer = client.read_object('Customer', 'HOUSE')
      expect(updated_customer['customerLegalName']).to eq('Updated Name')
    end
  end

  describe 'transactions' do
    it 'allows starting and committing a transaction', :vcr do
      client.start_transaction
      house_customer['email'] = 'testing@example.com'
      client.update_object('Customer', house_customer)
      client.commit_transaction
      updated_customer = client.read_object('Customer', 'HOUSE')
      expect(updated_customer['email']).to eq 'testing@example.com'
    end

    it 'allows rolling back and transaction after start', :vcr do
      client.start_transaction
      house_customer['webSite'] = 'https://example.com'
      client.update_object('Customer', house_customer)
      client.rollback_transaction
      updated_customer = client.read_object('Customer', 'HOUSE')
      expect(updated_customer['webSite']).to be_blank
    end
  end
end
