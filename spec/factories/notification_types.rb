FactoryBot.define do
  factory :global_validity_notification, class: 'Notifications::GlobalValidityNotification' do
    security_roles { [create(:security_role, :admin)] }
  end

  factory :new_user_signed_up_notification, class: 'Notifications::NewUserSignedUpNotification' do
    security_roles { [create(:security_role, :admin)] }
  end

  factory :user_was_approved_notification, class: 'Notifications::UserWasApprovedNotification' do
    security_roles { [create(:security_role, :admin)] }
  end

  factory :user_accepts_invitation_notification, class: 'Notifications::UserAcceptsInvitationNotification' do
    security_roles { [create(:security_role, :admin)] }
  end

  factory :new_division_notification, class: 'Notifications::NewDivisionNotification'
end
