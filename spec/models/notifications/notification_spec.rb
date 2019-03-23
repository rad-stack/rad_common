require 'rails_helper'

RSpec.describe Notifications::Notification, type: :model do
  let!(:admin) { create :admin }
  let(:notification) { Notifications::NewUserSignedUpNotification.new }

  describe '#notify_list' do
    subject { notification.send(:notify_list) }
    it { is_expected.to eq [admin] }

    context 'when user opts out' do
      let!(:another) { create :admin }

      before do
        create :notification_setting, user: admin,
                                      notification_type: 'Notifications::NewUserSignedUpNotification',
                                      enabled: false
      end

      it { is_expected.to include another }
      it { is_expected.to_not include admin }
    end
  end

  describe '#notify_user_ids' do
    subject { notification.send(:notify_user_ids) }
    it { is_expected.to eq [admin.id] }
  end
end
