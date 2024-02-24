require 'rails_helper'

describe DuplicateFixable do
  # TODO: mock this more to remove some of the lets

  let(:phone_number) { create :phone_number }
  let(:email) { Faker::Internet.email }
  let(:first_name) { 'John' }
  let(:last_name) { 'Smith' }
  let(:created_by) { create :user }

  let!(:attorney_1) do
    create :attorney, attorney_1_attributes.merge(company_name: 'ABC',
                                                  address_1: 'Xxxx',
                                                  address_2: nil,
                                                  city: 'Xxxx',
                                                  state: 'FL',
                                                  zipcode: '11111')
  end

  let(:attorney_1_attributes) do
    { phone_number: phone_number, email: email, first_name: 'Xxxx', last_name: 'Tttt' }
  end

  let(:attorney_2_attributes) do
    { phone_number: phone_number, email: email, first_name: 'Yyyy', last_name: 'Ssss' }
  end

  before do
    create :admin

    create :attorney, attorney_2_attributes.merge(company_name: 'XYZ',
                                                  address_1: 'Yyyy',
                                                  address_2: nil,
                                                  city: 'Yyyy',
                                                  state: 'CA',
                                                  zipcode: '22222')
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
