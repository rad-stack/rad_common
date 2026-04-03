require 'rails_helper'

RSpec.describe Notifications::AttorneyChangedNotification do
  before { create :admin }

  describe 'add_defaults' do
    it 'sets default_email and default_sms when notification type is auto-created' do
      create :attorney
      notification_type = NotificationType.find_by(type: 'Notifications::AttorneyChangedNotification')

      expect(notification_type).to be_present
      expect(notification_type.default_email).to be true
      expect(notification_type.default_sms).to be true
      expect(notification_type.default_feed).to be false
    end
  end

  describe 'enabled_for_method?' do
    let(:notification_type) { Notifications::AttorneyChangedNotification.main }

    context 'when user has no notification setting record' do
      let(:user) { create :admin }

      before { NotificationSetting.where(notification_type: notification_type, user: user).destroy_all }

      it 'falls back to default_sms when user has a mobile phone' do
        expect(notification_type.send(:enabled_for_method?, user.id, :sms)).to be true
      end

      it 'returns false for sms when user has no mobile phone' do
        user.update_columns(mobile_phone: nil)
        expect(notification_type.send(:enabled_for_method?, user.id, :sms)).to be false
      end

      it 'still falls back to default_email regardless of mobile phone' do
        user.update_columns(mobile_phone: nil)
        expect(notification_type.send(:enabled_for_method?, user.id, :email)).to be true
      end
    end
  end
end
