FactoryBot.define do
  factory :user_notification do
    enabled { true }
    association :user
    association :notification
  end
end
