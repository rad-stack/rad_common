FactoryBot.define do
  factory :notification_setting do
    enabled { true }
    association :user
    notification_type { 'Notifications::NewUserSignedUpNotification' }
  end
end
