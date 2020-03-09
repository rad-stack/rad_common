FactoryBot.define do
  factory :security_roles_user do
    association :user
    association :security_role
  end
end
