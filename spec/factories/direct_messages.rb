FactoryBot.define do
  factory :direct_message do
    sender factory: :user
    recipient factory: :user
    log { [] }
  end
end
