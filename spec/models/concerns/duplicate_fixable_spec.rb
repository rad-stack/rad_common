require 'rails_helper'

describe DuplicateFixable, type: :model do
  let(:phone_number) { create :phone_number }
  let(:email) { Faker::Internet.email }
  let(:first_name) { 'John' }
  let(:last_name) { 'Smith' }

  let!(:attorney_1) do
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

  describe 'process_duplicates' do
    subject { attorney_1.duplicate.score }

    before do
      attorney_1.process_duplicates
      attorney_1.reload
    end

    context 'when matching only on additional items' do
      let(:attorney_1_attributes) do
        { phone_number: phone_number, email: email, first_name: 'Xxxx', last_name: 'Tttt' }
      end

      let(:attorney_2_attributes) do
        { phone_number: phone_number, email: email, first_name: 'Yyyy', last_name: 'Ssss' }
      end

      it { is_expected.to eq 32 }
    end

    context 'when matching on standard plus additional items' do
      let(:attorney_1_attributes) do
        { phone_number: phone_number, email: email, first_name: first_name, last_name: last_name }
      end

      let(:attorney_2_attributes) do
        { phone_number: phone_number, email: email, first_name: first_name, last_name: last_name }
      end

      it { is_expected.to eq 46 }
    end
  end

  describe 'all_matches' do
    subject { attorney_1.send(:all_matches) }

    context 'when matching only on additional items' do
      let(:attorney_1_attributes) do
        { phone_number: phone_number, email: email, first_name: 'Xxxx', last_name: 'Tttt' }
      end

      let(:attorney_2_attributes) do
        { phone_number: phone_number, email: email, first_name: 'Yyyy', last_name: 'Ssss' }
      end

      it { is_expected.to include attorney_2.id }
    end

    context 'when matching on standard plus additional items' do
      let(:attorney_1_attributes) do
        { phone_number: phone_number, email: email, first_name: first_name, last_name: last_name }
      end

      let(:attorney_2_attributes) do
        { phone_number: phone_number, email: email, first_name: first_name, last_name: last_name }
      end

      it { is_expected.to include attorney_2.id }
    end
  end
end
