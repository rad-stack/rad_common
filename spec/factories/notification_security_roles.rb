FactoryBot.define do
  factory :notification_security_role do
    association :notification_type
    association :security_role
  end
end
