FactoryBot.define do
  factory :notification_setting do
    enabled { true }
    email { true }
    user
  end
end
