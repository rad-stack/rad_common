FactoryBot.define do
  factory :security_role do
    sequence(:name) { |n| "Role #{n}" }
    read_division { true }
  end
end
