require 'rails_helper'

describe DuplicateFixable do
  let(:attorney) { create :attorney }
  let(:created_by) { create :user }
  let!(:admin) { create :admin }
  let(:bypass_notifications) { false }

  let!(:attorney_2) do
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
    allow(attorney).to receive(:created_by).and_return(created_by)
    ActionMailer::Base.deliveries.clear
  end

  describe '.process_duplicates' do
    before { allow_any_instance_of(Duplicate).to receive :maybe_notify! }

    it 'adds duplicate records' do
      expect { Attorney.process_duplicates(nil) }.to change(Duplicate, :count).by(2)
    end
  end

  describe '#process_duplicates' do
    before do
      attorney.process_duplicates(bypass_notifications: bypass_notifications)
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

  describe 'reset_duplicates' do
    before do
      attorney.process_duplicates(bypass_notifications: bypass_notifications)
      attorney.reload
    end

    it "doesn't notify when duplicates are reset" do
      expect(ActionMailer::Base.deliveries.count).to eq 2
      ActionMailer::Base.deliveries.clear
      attorney.reset_duplicates
      expect(ActionMailer::Base.deliveries.count).to eq 0
    end

    context 'when bypassing notifications' do
      let(:bypass_notifications) { true }

      it "doesn't notify" do
        expect(ActionMailer::Base.deliveries.count).to eq 0
      end
    end
  end
end
