FactoryBot.define do
  factory :security_role do
    sequence(:name) { |n| "Role #{n}" }
    read_division { true }

    trait :admin do |item|
      item.after(:build) do |role|
        SecurityRole.permission_fields.each { |i| role.send(i + '=', true) }
      end

      item.after(:create) do |role|
        role.notification_security_roles.find_or_create_by! notification_type: 'Notifications::NewUserSignedUpNotification'
        role.notification_security_roles.find_or_create_by! notification_type: 'Notifications::UserWasApprovedNotification'
        role.notification_security_roles.find_or_create_by! notification_type: 'Notifications::UserAcceptsInvitationNotification'
        role.notification_security_roles.find_or_create_by! notification_type: 'Notifications::GlobalValidityNotification'
      end
    end
  end
end
