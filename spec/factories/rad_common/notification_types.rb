FactoryBot.define do
  factory :global_validity_notification, class: 'Notifications::InvalidDataWasFoundNotification' do
    security_roles { [create(:security_role, :admin)] }
  end

  factory :new_user_signed_up_notification, class: 'Notifications::NewUserSignedUpNotification' do
    security_roles { [create(:security_role, :admin)] }
  end

  factory :user_was_approved_notification, class: 'Notifications::UserWasApprovedNotification' do
    security_roles { [create(:security_role, :admin)] }
  end

  factory :user_accepts_invitation_notification, class: 'Notifications::UserAcceptedInvitationNotification' do
    security_roles { [create(:security_role, :admin)] }
  end
end
