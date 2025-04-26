require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) { described_class.main }

  describe 'valid user domains' do
    it 'allows valid user domains' do
      company.update! valid_user_domains: %w[foo.bar me.too]
      expect(company.valid_user_domains).to eq %w[foo.bar me.too]
    end

    it 'strips blank user domains' do
      company.update! valid_user_domains: [' foo.bar', 'me.too ']
      expect(company.valid_user_domains).to eq %w[foo.bar me.too]
    end
  end

  describe '#full_address' do
    subject { company.full_address }

    before do
      company.update! address_1: 'Address 1',
                      address_2: 'Address 2',
                      city: 'City',
                      state: 'HI',
                      zipcode: '96818'
    end

    context 'with address 2' do
      xit { is_expected.to eq 'Address 1, Address 2, City, HI 96818' }
    end

    context 'without address 2' do
      before { company.update! address_2: nil }

      it { is_expected.to eq 'Address 1, City, HI 96818' }
    end
  end

  describe 'validate' do
    it 'requires at least one valid user domain' do
      company.valid_user_domains = []
      expect(company.valid?).to be false
      expect(company.errors.full_messages.to_s).to include 'needs at least one domain'

      company.valid_user_domains = ['example.com']
      expect(company.valid?).to be true
    end
  end
end
