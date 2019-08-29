require 'rails_helper'

RSpec.describe SystemMessage, type: :model do
  let(:user) { create :admin }
  let(:message) { 'foo bar yo' }
  let(:system_message) { create :system_message, user: user, message: message }

  describe '#send!' do
    let(:mail) { ActionMailer::Base.deliveries.last }

    before do
      ActionMailer::Base.deliveries = []
      system_message.send!(user)
    end

    subject { mail.body.encoded }

    it { is_expected.to include message }
  end
end
