require 'rails_helper'

RSpec.describe DuplicatesProcessor do
  subject { described_class.new(attorney_1).matches }

  let(:first_name) { 'John' }
  let(:last_name) { 'Smith' }
  let(:company_name) { 'ABC' }
  let(:address_1) { '100 8th St' }
  let(:address_2) { nil }
  let(:city) { 'Honolulu' }
  let(:state) { 'HI' }
  let(:zipcode) { '11111' }
  let(:phone_number) { '(111) 111-1111' }
  let(:email) { '111@abc.com' }

  let(:attorney_1) do
    create :attorney,
           first_name: first_name,
           last_name: last_name,
           company_name: company_name,
           address_1: address_1,
           address_2: address_2,
           city: city,
           state: state,
           zipcode: zipcode,
           phone_number: phone_number,
           email: email
  end

  context 'when matching only on additional items' do
    let!(:attorney_2) do
      create :attorney,
             first_name: 'Yyyy',
             last_name: 'Ssss',
             company_name: 'XYZ',
             address_1: 'Yyyy',
             address_2: address_2,
             city: 'Yyyy',
             state: 'CA',
             zipcode: '22222',
             phone_number: phone_number,
             email: email
    end

    it { is_expected.to eq [{ id: attorney_2.id, score: 28 }] }
  end

  context 'when matching on standard plus additional items' do
    let!(:attorney_2) do
      create :attorney,
             first_name: first_name,
             last_name: last_name,
             company_name: 'XYZ',
             address_1: 'Yyyy',
             address_2: address_2,
             city: 'Yyyy',
             state: 'CA',
             zipcode: '22222',
             phone_number: phone_number,
             email: email
    end

    it { is_expected.to eq [{ id: attorney_2.id, score: 40 }] }
  end

  context 'when matching only on additional items 2' do
    let!(:attorney_2) do
      create :attorney,
             first_name: first_name,
             last_name: last_name,
             company_name: attorney_1.company_name,
             address_1: attorney_1.address_1,
             address_2: address_2,
             city: attorney_1.city,
             state: attorney_1.state,
             zipcode: '22222',
             phone_number: '(222) 222-2222',
             email: '222@xyz.com'
    end

    it { is_expected.to eq [{ id: attorney_2.id, score: 43 }] }
  end
end
