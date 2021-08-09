FactoryBot.define do
  factory :notification_setting do
    enabled { true }
    email { true }
    association :user
  end
end
