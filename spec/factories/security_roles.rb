FactoryBot.define do
  factory :security_role do
    sequence(:name) { |n| "Role #{n}" }
    read_division { true }

    trait :admin do |item|
      item.after(:build) do |role|
        SecurityRole.permission_fields.each { |i| role.send(i + '=', true) }
      end
    end
  end
end
