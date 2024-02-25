require 'rails_helper'

RSpec.describe DuplicatesProcessor do
  # TODO: this might be similar to the stuff in duplicate_fixable_spec

  let(:attorney) { create :attorney }
  let(:created_by) { create :user }
  let!(:admin) { create :admin }

  let(:attorney_2) do
    create :attorney,
           first_name: attorney.first_name,
           last_name: attorney.last_name,
           company_name: attorney.company_name,
           address_1: attorney.address_1,
           address_2: attorney.address_2,
           city: attorney.city,
           state: attorney.state,
           zipcode: attorney.zipcode
  end

  before do
    attorney_2
    allow(attorney).to receive(:created_by).and_return(created_by)
    attorney.process_duplicates
    attorney.reload
  end

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
