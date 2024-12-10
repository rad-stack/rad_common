FactoryBot.define do
  factory :user_client do
    association :user
    association :client
  end
end
