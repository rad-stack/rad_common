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
end
