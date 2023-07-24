require 'rails_helper'

describe DuplicateFixable do
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

    let(:created_by_user) { create :user }
    let!(:admin) { create :admin }

    before do
      allow_any_instance_of(Notifications::PossibleDuplicateFoundNotification).to receive(:created_by_user)
        .and_return(created_by_user)
      allow_any_instance_of(Notifications::PossibleDuplicateAdminNotification).to receive(:created_by_user)
        .and_return(created_by_user)
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

    context 'when matching only on additional items 2' do
      let(:attorney_1) do
        create :attorney, first_name: 'John',
                          last_name: 'Smith',
                          company_name: 'ABC',
                          address_1: 'Yyyy',
                          address_2: nil,
                          city: 'Xxxx',
                          state: 'FL',
                          zipcode: '11111'
      end

      let(:attorney_2) do
        create :attorney, first_name: 'John',
                          last_name: 'Smith',
                          company_name: 'ABC',
                          address_1: 'Yyyy',
                          address_2: nil,
                          city: 'Xxxx',
                          state: 'FL',
                          zipcode: '22222'
      end

      it { is_expected.to eq 50 }

      it 'sends notifications' do
        expect(ActionMailer::Base.deliveries.first.subject).to eq 'Possible duplicate found'
        expect(ActionMailer::Base.deliveries.first.to).to include created_by_user.email

        expect(ActionMailer::Base.deliveries.second.subject).to eq 'Possible duplicate found'
        expect(ActionMailer::Base.deliveries.second.to).to include admin.email
      end
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
