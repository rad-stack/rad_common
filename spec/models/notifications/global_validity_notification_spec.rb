require 'rails_helper'

RSpec.describe Notifications::GlobalValidityNotification, type: :model do
  let!(:admin) { create :admin }
  let(:notification) { described_class }
  let(:mail) { ActionMailer::Base.deliveries.last }

  describe '#notify!' do
    before do
      ActionMailer::Base.deliveries = []
      notification.notify! []
    end

    it 'emails' do
      expect(mail.subject).to eq "Invalid data in #{I18n.t(:app_name)}"
    end
  end
end
