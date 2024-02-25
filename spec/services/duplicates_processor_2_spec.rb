require 'rails_helper'

RSpec.describe DuplicatesProcessor do
  let(:phone_number) { create :phone_number }
  let(:email) { Faker::Internet.email }
  let(:created_by) { create :user }

  before { attorney_2 }

  describe 'matches' do
    subject { described_class.new(attorney_1).matches }

    context 'when matching only on additional items' do
      let(:attorney_1) do
        create :attorney, attorney_1_attributes.merge(company_name: 'ABC',
                                                      address_1: 'Xxxx',
                                                      address_2: nil,
                                                      city: 'Xxxx',
                                                      state: 'FL',
                                                      zipcode: '11111')
      end

      let(:attorney_2) do
        create :attorney, attorney_2_attributes.merge(company_name: 'XYZ',
                                                      address_1: 'Yyyy',
                                                      address_2: nil,
                                                      city: 'Yyyy',
                                                      state: 'CA',
                                                      zipcode: '22222')
      end

      let(:attorney_1_attributes) do
        { phone_number: phone_number, email: email, first_name: 'Xxxx', last_name: 'Tttt' }
      end

      let(:attorney_2_attributes) do
        { phone_number: phone_number, email: email, first_name: 'Yyyy', last_name: 'Ssss' }
      end

      it { is_expected.to eq [{ id: attorney_2.id, score: 32 }] }
    end

    context 'when matching on standard plus additional items' do
      let(:first_name) { 'John' }
      let(:last_name) { 'Smith' }

      let(:attorney_1) do
        create :attorney, attorney_1_attributes.merge(company_name: 'ABC',
                                                      address_1: 'Xxxx',
                                                      address_2: nil,
                                                      city: 'Xxxx',
                                                      state: 'FL',
                                                      zipcode: '11111')
      end

      let(:attorney_2) do
        create :attorney, attorney_2_attributes.merge(company_name: 'XYZ',
                                                      address_1: 'Yyyy',
                                                      address_2: nil,
                                                      city: 'Yyyy',
                                                      state: 'CA',
                                                      zipcode: '22222')
      end

      let(:attorney_1_attributes) do
        { phone_number: phone_number, email: email, first_name: first_name, last_name: last_name }
      end

      let(:attorney_2_attributes) do
        { phone_number: phone_number, email: email, first_name: first_name, last_name: last_name }
      end

      it { is_expected.to eq [{ id: attorney_2.id, score: 46 }] }
    end

    context 'when matching only on additional items 2' do
      let(:attorney_1) do
        create :attorney, address_2: 'Suite 111', zipcode: '11111', phone_number: '(111) 111-1111', email: '111@abc.com'
      end

      let(:attorney_2) do
        create :attorney,
               first_name: attorney_1.first_name,
               last_name: attorney_1.last_name,
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
