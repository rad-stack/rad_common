class ContactLogRecipient < ApplicationRecord
  belongs_to :contact_log
  belongs_to :to_user, class_name: 'User', optional: true

  enum email_type: { to: 0, cc: 1, bcc: 2 }
  # TODO: Determine twilio and sendgrid status differences
  enum service_status: { accepted: 0,
                         scheduled: 1,
                         queued: 2,
                         sending: 3,
                         sent: 4,
                         receiving: 5,
                         delivered: 6,
                         undelivered: 7,
                         failed: 8 }, _prefix: true
end
