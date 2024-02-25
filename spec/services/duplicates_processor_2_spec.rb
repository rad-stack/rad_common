require 'rails_helper'

RSpec.describe DuplicatesProcessor do
  let(:phone_number) { create :phone_number }
  let(:email) { Faker::Internet.email }
  let(:first_name) { 'John' }
  let(:last_name) { 'Smith' }
  let(:created_by) { create :user }

  let(:attorney_1) do
    create :attorney, attorney_1_attributes.merge(company_name: 'ABC',
                                                  address_1: 'Xxxx',
                                                  address_2: nil,
                                                  city: 'Xxxx',
                                                  state: 'FL',
                                                  zipcode: '11111')
  end

  let!(:attorney_2) do
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

  describe 'matches' do
    subject { described_class.new(attorney_1).matches }

    context 'when matching only on additional items' do
      it { is_expected.to eq [{ id: attorney_2.id, score: 32 }] }
    end

    context 'when matching on standard plus additional items' do
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
        create :attorney,
               first_name: 'John',
               last_name: 'Smith',
               company_name: 'ABC',
               address_1: 'Yyyy',
               address_2: nil,
               city: 'Xxxx',
               state: 'FL',
               zipcode: '11111'
      end

      let(:attorney_2) do
        create :attorney,
               first_name: 'John',
               last_name: 'Smith',
               company_name: 'ABC',
               address_1: 'Yyyy',
               address_2: nil,
               city: 'Xxxx',
               state: 'FL',
               zipcode: '22222'
      end

      it { is_expected.to eq [{ id: attorney_2.id, score: 50 }] }
    end
  end
end
