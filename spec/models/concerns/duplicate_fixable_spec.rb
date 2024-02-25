require 'rails_helper'

describe DuplicateFixable do
  let(:attorney) { create :attorney }
  let(:created_by) { create :user }

  before do
    create :admin

    create :attorney,
           company_name: attorney.company_name,
           address_1: attorney.address_1,
           address_2: attorney.address_2,
           city: attorney.city,
           state: attorney.state,
           zipcode: attorney.zipcode

    allow(Attorney).to receive(:score_upper_threshold).and_return(10)
    allow(attorney).to receive(:created_by).and_return(created_by)

    ActionMailer::Base.deliveries.clear
  end

  describe 'reset_duplicates' do
    it "doesn't notify when duplicates are reset" do
      attorney.process_duplicates
      attorney.reload

      expect(ActionMailer::Base.deliveries.count).to eq 2
      ActionMailer::Base.deliveries.clear
      attorney.reset_duplicates
      expect(ActionMailer::Base.deliveries.count).to eq 0
    end

    it 'optionally bypasses notifications' do
      attorney.process_duplicates(bypass_notifications: true)

      expect(ActionMailer::Base.deliveries.count).to eq 0
    end
  end
end
