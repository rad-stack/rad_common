module RadCommon
  module UsersHelper
    def user_show_data(user)
      items = [:email,
               :mobile_phone,
               { label: 'User Status', value: user_status_item(user) },
               :timezone,
               :detected_timezone,
               :ignored_timezone,
               :sign_in_count,
               :invitation_accepted_at,
               :invited_by]

      items += %i[twilio_verify_sms] if RadConfig.twilio_verify_enabled?
      items += %i[current_sign_in_ip current_sign_in_at confirmed_at confirmation_sent_at unconfirmed_email]
      items.push(:last_activity_at) if user.respond_to?(:last_activity_at)

      if RadConfig.avatar? && user.avatar.attached?
        items.push(label: 'Avatar',
                   value: render('layouts/attachment', record: user, attachment_name: 'avatar', new_tab: true))
      end

      items
    end

    def user_status_item(user)
      items = [user.user_status.name, ' ']

      if user.needs_confirmation?
        items += user_status_icon('fa-circle-question', 'This user has not yet confirmed their email.')
      end

      if user.needs_accept_invite?
        items += user_status_icon('fa-envelope', 'This user has not yet accepted their invitation.')
      end

      if user.needs_reactivate?
        items += user_status_icon('fa-triangle-exclamation', 'This user is expired due to inactivity.')
      end

      tag.div do
        safe_join items
      end
    end

    def user_status_icon(icon, tooltip)
      [icon_tooltip('span', tooltip, icon, html_class: 'text-warning'), ' ']
    end

    def my_profile_nav?
      UserProfilePolicy.new(current_user, current_user).show?
    end

    def next_profile_action(user)
      onboarding = Onboarding.new(user)

      next_step = onboarding.next_step
      return unless next_step

      link_to(icon(:forward, next_step.label), next_step.path, class: 'btn btn-primary btn-lg')
    end

    def users_actions
      [invite_user_action, new_user_action]
    end

    def invite_user_action
      return unless policy(User.new).new? && !RadConfig.disable_invite?

      link_to(icon('plus-square', 'Invite User'), new_user_invitation_path, class: 'btn btn-success btn-sm')
    end

    def new_user_action
      return unless policy(User.new).new? && manually_create_users?

      link_to(icon('plus-square', 'New User'), new_user_path, class: 'btn btn-success btn-sm')
    end

    def manually_create_users?
      RadConfig.disable_invite? && RadConfig.disable_sign_up?
    end

    def user_actions(user)
      [user_confirm_action(user),
       user_resend_action(user),
       user_profile_action(user),
       user_test_email_action(user),
       user_test_sms_action(user),
       impersonate_action(user)]
    end

    def user_profile_action(user)
      return unless UserProfilePolicy.new(current_user, user).show?

      link_to icon(:user, 'Profile'), "/user_profiles/#{user.id}", class: 'btn btn-secondary btn-sm'
    end

    def profile_show_title(user)
      return 'My Profile' if user == current_user

      "Profile for #{user}"
    end

    def edit_profile_button(user)
      return unless UserProfilePolicy.new(current_user, user).edit?

      link_to(icon(:pencil, 'Edit'), edit_user_profile_path(user), class: 'btn btn-secondary btn-sm')
    end

    def profile_edit_title(user)
      return safe_join(['Editing Profile for ', link_to(user, user_profile_path(user))]) unless user == current_user
      return safe_join(['Editing ', link_to('My Profile', user_profile_path(user))]) if Onboarding.new(user).onboarded?

      'Please Enter Your Profile'
    end

    def user_index_actions(user)
      items = []

      items.push(add_user_client_action(user, true))

      if policy(user).update?
        items.push(link_to(icon(:pencil, 'Edit'), edit_user_path(user), class: 'btn btn-secondary btn-sm btn-block'))
      end

      if policy(user).destroy?
        items.push(link_to(icon(:times, 'Delete'),
                           user,
                           method: :delete,
                           data: { confirm: 'Are you sure?' },
                           class: 'btn btn-danger btn-sm btn-block'))
      end

      items
    end

    def impersonate_action(user)
      return unless policy(user).impersonate?

      link_to icon('right-to-bracket', 'Sign In As'),
              "/rad_common/impersonations/start?id=#{user.id}",
              method: :post,
              data: { confirm: 'Sign in as this user? Note that any audit trail records will still be associated to ' \
                               'your original user.' },
              class: 'btn btn-warning btn-sm'
    end

    def impersonating?
      current_user != true_user
    end

    def impersonate_style
      impersonating? ? 'text-danger' : ''
    end

    def user_confirm_action(user)
      return unless RadConfig.user_confirmable? && policy(user).update? && !user.confirmed?

      confirm = "This will manually confirm the user's email address and bypass this verification step. Are you sure?"
      link_to icon(:check, 'Confirm Email'),
              confirm_user_path(user),
              method: :put,
              data: { confirm: confirm },
              class: 'btn btn-warning btn-sm'
    end

    def user_resend_action(user)
      return unless policy(User.new).create? && user.invitation_sent_at.present? && user.invitation_accepted_at.blank?

      link_to 'Resend Invitation',
              resend_invitation_user_path(user),
              method: :put,
              class: 'btn btn-sm btn-success',
              data: { confirm: 'Are you sure?' }
    end

    def user_test_email_action(user)
      return unless policy(user).test_email?

      link_to icon(:envelope, 'Send Test Email'),
              test_email_user_path(user),
              method: :put,
              class: 'btn btn-secondary btn-sm',
              data: { confirm: 'Are you sure?' }
    end

    def user_test_sms_action(user)
      return unless RadConfig.twilio_enabled? && user.mobile_phone.present? && policy(user).test_sms?

      link_to icon(:comments, 'Send Test SMS'),
              test_sms_user_path(user),
              method: :put,
              class: 'btn btn-secondary btn-sm',
              data: { confirm: 'Are you sure?' }
    end

    def user_client_actions(user)
      [add_user_client_action(user, false)]
    end

    def add_user_client_action(user, index_page)
      return unless RadConfig.user_clients? && user.external? && policy(UserClient.new(user: user)).new?

      link_class = index_page ? 'btn btn-sm btn-success btn-block' : 'btn btn-sm btn-success'

      link_to(icon(:plus, "Add #{RadCommon::AppInfo.new.client_model_label} to User"),
              [:new, user, :user_client],
              class: link_class)
    end

    def reactivate_user_warning(user)
      return unless RadConfig.user_expirable? && policy(user).update? && user.expired?

      link = link_to 'click here', reactivate_user_path(user), method: :put, data: { confirm: 'Are you sure?' }
      message = safe_join(["User's account has been expired due to inactivity, to re-activate the user, ", link, '.'])
      content_tag(:p, message, class: 'alert alert-warning')
    end

    def require_mobile_phone?
      RadConfig.twilio_verify_enabled? && !RadConfig.twilio_verify_internal_only?
    end
  end
end
