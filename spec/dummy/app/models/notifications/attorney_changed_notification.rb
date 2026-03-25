module Notifications
  class AttorneyChangedNotification < ::NotificationType
    def sms_enabled?
      true
    end

    def feed_enabled?
      false
    end

    def add_defaults
      self.default_email = true
      self.default_sms = true
    end
  end
end
