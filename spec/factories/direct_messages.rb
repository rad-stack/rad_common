FactoryBot.define do
  factory :direct_message do
    from_user { association :user }
    to_user { association :user }
    log { [] }
  end
end
