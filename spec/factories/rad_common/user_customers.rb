FactoryBot.define do
  factory :user_customer do
    association :user
    association :customer
  end
end
