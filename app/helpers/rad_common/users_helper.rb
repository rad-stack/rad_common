module RadCommon
  module UsersHelper
    def user_show_data(user)
      items = %i[email mobile_phone user_status timezone sign_in_count invitation_accepted_at invited_by]
      items += %i[authy_id authy_sms] if RadicalConfig.authy_enabled?
      items += %i[current_sign_in_ip current_sign_in_at confirmed_at confirmation_sent_at unconfirmed_email]
      items.push(:last_activity_at) if user.respond_to?(:last_activity_at)

      if RadicalConfig.avatar? && user.avatar.attached?
        items.push(label: 'Avatar',
                   value: render_one_attachment(record: user, attachment_name: 'avatar', new_tab: true))
      end

      items
    end

    def my_profile_nav?
      UserProfilePolicy.new(current_user, current_user).show?
    end

    def show_nav_avatar
      return unless RadicalConfig.avatar?

      # there is a complicated bug that requires this - Task 35304
      return if RadicalConfig.password_expirable? && current_user.password_expired?

      return unless current_user.avatar.attached?

      image_tag current_user.avatar.variant(resize: '100x100'), class: 'user-icon'
    end

    def users_actions
      [invite_user_action, new_user_action]
    end

    def invite_user_action
      return unless policy(User.new).new? && !RadicalConfig.disable_invite?

      link_to(icon('plus-square', 'Invite User'), new_user_invitation_path, class: 'btn btn-success btn-sm')
    end

    def new_user_action
      return unless policy(User.new).new? && RadicalConfig.manually_create_users?

      link_to(icon('plus-square', 'New User'), new_user_path, class: 'btn btn-success btn-sm')
    end

    def user_actions(user)
      [user_confirm_action(user),
       user_resend_action(user),
       user_profile_action(user),
       user_reset_authy_action(user),
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
      return unless RadicalConfig.user_confirmable? && policy(user).update? && !user.confirmed?

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

    def user_reset_authy_action(user)
      return unless RadicalConfig.authy_enabled? && policy(user).update? && user.twilio_verify_enabled?

      confirm = "This will reset the user's two factor authentication configuration if they are having problems. " \
                'Are you sure?'

      link_to icon(:refresh, 'Reset Two Factor'),
              reset_authy_user_path(user),
              method: :put,
              data: { confirm: confirm },
              class: 'btn btn-warning btn-sm'
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
      return unless RadicalTwilio.new.twilio_enabled? && user.mobile_phone.present? && policy(user).test_sms?

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
      return unless RadicalConfig.user_clients? && user.external? && policy(UserClient.new(user: user)).new?

      link_class = index_page ? 'btn btn-sm btn-success btn-block' : 'btn btn-sm btn-success'

      link_to(icon(:plus, "Add #{RadCommon::AppInfo.new.client_model_label} to User"),
              [:new, user, :user_client],
              class: link_class)
    end

    def reactivate_user_warning(user)
      return unless RadicalConfig.user_expirable? && policy(user).update? && user.expired?

      link = link_to 'click here', reactivate_user_path(user), method: :put, data: { confirm: 'Are you sure?' }
      message = safe_join(["User's account has been expired due to inactivity, to re-activate the user, ", link, '.'])
      content_tag(:p, message, class: 'alert alert-warning')
    end

    def require_mobile_phone?
      RadicalConfig.authy_enabled? && !RadicalConfig.authy_internal_only?
    end

    def clients_to_add_to_user(user)
      policy_scope(RadCommon::AppInfo.new.client_model_class).active.where.not(id: user.clients.pluck(:id)).sorted
    end

    def show_hide_users_button(users)
      return if users.inactive.none?

      tag.button 'Show/Hide Inactive',
                 type: 'button',
                 class: 'btn btn-sm btn-secondary',
                 'data-target': '#users-collapse',
                 'data-toggle': 'collapse'
    end

    def user_row_class(user, hide_inactive)
      item = user.display_style
      return item if !hide_inactive || user.not_inactive?

      "#{item} collapse"
    end

    def user_row_id(user, hide_inactive)
      return if !hide_inactive || user.not_inactive?

      'users-collapse'
    end
  end
end
