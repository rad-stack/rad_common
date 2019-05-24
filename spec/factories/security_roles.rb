FactoryBot.define do
  factory :security_role do
    sequence(:name) { |n| "Role #{n}" }
    read_division { true }

    trait :admin do |item|
      item.after(:build) do |role|
        SecurityRole.permission_fields.each { |i| role.send(i + '=', true) }
      end

      item.after(:create) do |role|
        NotificationType.all.each do |notification_type|
          role.notification_security_roles.find_or_create_by! notification_type: notification_type
        end
      end
    end
  end
end
