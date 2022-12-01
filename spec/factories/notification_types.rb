FactoryBot.define do
  factory :new_division_notification, class: 'Notifications::DivisionUpdatedNotification'
  factory :twilio_error_threshold_passed_notification, class: 'Notifications::TwilioErrorThresholdPassedNotification'
end
