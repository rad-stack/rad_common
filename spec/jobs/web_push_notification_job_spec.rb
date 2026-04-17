require 'rails_helper'

RSpec.describe WebPushNotificationJob do
  let(:user) { create :user }
  let(:notification_type) { Notifications::InvalidDataWasFoundNotification.main({}) }
  let(:notification) { create :notification, user: user, notification_type: notification_type }

  before do
    allow(RadConfig).to receive(:browser_notifications_enabled?).and_return(true)
  end

  describe '#perform' do
    context 'when notification is already read' do
      before { notification.update!(unread: false) }

      it 'does not send push notification' do
        expect_any_instance_of(PushSubscription).not_to receive(:push_message)
        described_class.new.perform(notification_id: notification.id, user_id: user.id)
      end
    end

    context 'when user has no push subscriptions' do
      it 'does not raise an error' do
        expect { described_class.new.perform(notification_id: notification.id, user_id: user.id) }
          .not_to raise_error
      end
    end

    context 'when notification no longer exists' do
      it 'raises ActiveRecord::RecordNotFound' do
        expect { described_class.new.perform(notification_id: -1, user_id: user.id) }
          .to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
