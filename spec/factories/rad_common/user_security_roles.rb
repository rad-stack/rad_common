FactoryBot.define do
  factory :user_security_role do
    association :user
    association :security_role
  end
end
