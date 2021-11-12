require 'rails_helper'

describe DuplicateFixable, type: :model do
  let(:phone_number) { create :phone_number }
  let(:email) { Faker::Internet.email }
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let!(:attorney_1) { create :attorney, attorney_attributes.merge(company_name: 'ABC') }
  let!(:attorney_2) { create :attorney, attorney_attributes.merge(company_name: 'XYZ') }

  describe 'process_duplicates' do
    subject { attorney_1.duplicate.score }

    before do
      attorney_1.process_duplicates
      attorney_1.reload
    end

    context 'when matching only on additional items' do
      let(:attorney_attributes) { { phone_number: phone_number, email: email } }

      it { is_expected.to eq 32 }
    end

    context 'when matching on standard plus additional items' do
      let(:attorney_attributes) do
        { phone_number: phone_number, email: email, first_name: first_name, last_name: last_name }
      end

      # TODO: this fails intermittently
      it { is_expected.to eq 46 }
    end
  end

  describe 'all_matches' do
    subject { attorney_1.send(:all_matches) }

    context 'when matching only on additional items' do
      let(:attorney_attributes) { { phone_number: phone_number, email: email } }

      it { is_expected.to include attorney_2.id }
    end

    context 'when matching on standard plus additional items' do
      let(:attorney_attributes) do
        { phone_number: phone_number, email: email, first_name: first_name, last_name: last_name }
      end

      it { is_expected.to include attorney_2.id }
    end
  end
end
