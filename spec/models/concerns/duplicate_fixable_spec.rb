require 'rails_helper'

describe DuplicateFixable do
  let(:phone_number) { create :phone_number }
  let(:email) { Faker::Internet.email }
  let(:first_name) { 'John' }
  let(:last_name) { 'Smith' }
  let(:created_by) { create :user }
  let!(:admin) { create :admin }

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

  let(:attorney_1_attributes) do
    { phone_number: phone_number, email: email, first_name: 'Xxxx', last_name: 'Tttt' }
  end

  let(:attorney_2_attributes) do
    { phone_number: phone_number, email: email, first_name: 'Yyyy', last_name: 'Ssss' }
  end

  describe 'process_duplicates' do
    subject { attorney_1.duplicate.score }

    before do
      allow(attorney_1).to receive(:created_by).and_return(created_by)
      attorney_1.process_duplicates
      attorney_1.reload
    end

    context 'when matching only on additional items' do
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
        expect(ActionMailer::Base.deliveries.first.subject).to eq "Possible Duplicate (#{attorney_2}) Entered By You"
        expect(ActionMailer::Base.deliveries.first.to).to include created_by.email

        expect(ActionMailer::Base.deliveries.second.subject)
          .to eq "Possible Duplicate (#{attorney_2}) Entered By #{created_by}"

        expect(ActionMailer::Base.deliveries.second.to).to include admin.email
      end

      context 'when admin user creates the duplicate' do
        let(:created_by) { admin }

        it 'only sends one notification' do
          expect(ActionMailer::Base.deliveries.count).to eq 1
        end
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
    subject { DuplicatesMatcher.new(attorney_1).send(:all_matches) }

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

  describe 'reset_duplicates' do
    it "doesn't notify when duplicates are reset" do
      allow(Attorney).to receive(:score_upper_threshold).and_return(10)
      allow(attorney_1).to receive(:created_by).and_return(created_by)

      ActionMailer::Base.deliveries.clear

      attorney_1.process_duplicates
      attorney_1.reload

      expect(ActionMailer::Base.deliveries.count).to eq 2
      ActionMailer::Base.deliveries.clear
      attorney_1.reset_duplicates
      expect(ActionMailer::Base.deliveries.count).to eq 0
    end

    it 'optionally bypasses notifications' do
      allow(Attorney).to receive(:score_upper_threshold).and_return(10)
      allow(attorney_1).to receive(:created_by).and_return(created_by)

      ActionMailer::Base.deliveries.clear
      attorney_1.process_duplicates(bypass_notifications: true)

      expect(ActionMailer::Base.deliveries.count).to eq 0
    end
  end
end
