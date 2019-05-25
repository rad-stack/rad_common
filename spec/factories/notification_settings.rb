FactoryBot.define do
  factory :notification_setting do
    enabled { true }
    association :user
  end
end
