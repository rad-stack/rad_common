require 'rails_helper'

RSpec.describe DuplicatesProcessor do
  let(:first_name) { 'John' }
  let(:last_name) { 'Smith' }
  let(:company_name) { 'ABC' }
  let(:address_1) { '100 8th St' }
  let(:city) { 'Honolulu' }
  let(:phone_number) { '(111) 111-1111' }
  let(:email) { '111@abc.com' }
  let(:created_by) { create :user }

  before { attorney_2 }

  describe 'matches' do
    subject { described_class.new(attorney_1).matches }

    context 'when matching only on additional items' do
      let(:attorney_1) do
        create :attorney,
               first_name: first_name,
               last_name: last_name,
               company_name: company_name,
               address_1: address_1,
               address_2: nil,
               city: city,
               state: 'FL',
               zipcode: '11111',
               phone_number: phone_number,
               email: email
      end

      let(:attorney_2) do
        create :attorney,
               first_name: 'Yyyy',
               last_name: 'Ssss',
               company_name: 'XYZ',
               address_1: 'Yyyy',
               address_2: nil,
               city: 'Yyyy',
               state: 'CA',
               zipcode: '22222',
               phone_number: phone_number,
               email: email
      end

      it { is_expected.to eq [{ id: attorney_2.id, score: 32 }] }
    end

    context 'when matching on standard plus additional items' do
      let(:attorney_1) do
        create :attorney,
               first_name: first_name,
               last_name: last_name,
               company_name: company_name,
               address_1: address_1,
               address_2: nil,
               city: city,
               state: 'FL',
               zipcode: '11111',
               phone_number: phone_number,
               email: email
      end

      let(:attorney_2) do
        create :attorney,
               first_name: first_name,
               last_name: last_name,
               company_name: 'XYZ',
               address_1: 'Yyyy',
               address_2: nil,
               city: 'Yyyy',
               state: 'CA',
               zipcode: '22222',
               phone_number: phone_number,
               email: email
      end

      it { is_expected.to eq [{ id: attorney_2.id, score: 46 }] }
    end

    context 'when matching only on additional items 2' do
      let(:attorney_1) do
        create :attorney,
               first_name: first_name,
               last_name: last_name,
               company_name: company_name,
               address_1: address_1,
               address_2: 'Suite 111',
               city: city,
               zipcode: '11111',
               phone_number: phone_number,
               email: email
      end

      let(:attorney_2) do
        create :attorney,
               first_name: first_name,
               last_name: last_name,
               company_name: attorney_1.company_name,
               address_1: attorney_1.address_1,
               address_2: 'Room 222',
               city: attorney_1.city,
               state: attorney_1.state,
               zipcode: '22222',
               phone_number: '(222) 222-2222',
               email: '222@xyz.com'
      end

      it { is_expected.to eq [{ id: attorney_2.id, score: 50 }] }
    end
  end
end
