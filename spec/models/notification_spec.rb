require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:admin) { create :admin }
  let(:notification) { Notifications::NewUserSignedUpNotification.new }

  describe '#notify_user_ids' do
    subject { notification.send(:notify_user_ids) }
    it { is_expected.to eq [admin.id] }
  end
end
