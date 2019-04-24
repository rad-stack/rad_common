FactoryBot.define do
  factory :security_role do
    sequence(:name) { |n| "Role #{n}" }
    read_division { true }

    trait :admin do |item|
      admin { true }
      read_user { true }
      read_audit { true }
      create_division { true }
      read_division { true }
      update_division { true }
      delete_division { true }

      item.after(:create) do |role|
        role.notification_security_roles.create! notification_type: 'Notifications::NewUserSignedUpNotification'
        role.notification_security_roles.create! notification_type: 'Notifications::UserWasApprovedNotification'
        role.notification_security_roles.create! notification_type: 'Notifications::UserAcceptsInvitationNotification'
        role.notification_security_roles.create! notification_type: 'Notifications::GlobalValidityNotification'
      end
    end
  end
end
