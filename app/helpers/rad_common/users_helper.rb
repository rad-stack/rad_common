module RadCommon
  module UsersHelper
    def user_show_data(user)
      items = %i[email mobile_phone user_status timezone sign_in_count invitation_accepted_at invited_by]
      items.push(:authy_id) if RadicalConfig.authy_enabled?
      items += %i[current_sign_in_ip current_sign_in_at confirmed_at confirmation_sent_at unconfirmed_email]
      items.push(:last_activity_at) if user.respond_to?(:last_activity_at)

      if RadicalConfig.avatar? && user.avatar.attached?
        items.push(label: 'Avatar',
                   value: render('layouts/attachment', record: user, attachment_name: 'avatar', new_tab: true))
      end

      items
    end

    def users_actions
      [invite_user_action, new_user_action]
    end

    def invite_user_action
      return unless policy(User.new).new? && !RadicalConfig.disable_invite?

      link_to(icon('plus-square', 'Invite User'), new_user_invitation_path, class: 'btn btn-success btn-sm')
    end

    def new_user_action
      return unless policy(User.new).new? && manually_create_users?

      link_to(icon('plus-square', 'New User'), new_user_path, class: 'btn btn-success btn-sm')
    end

    def manually_create_users?
      RadicalConfig.disable_invite? && RadicalConfig.disable_sign_up?
    end

    def user_actions(user)
      [user_confirm_action(user),
       user_resend_action(user),
       user_reset_authy_action(user),
       user_test_email_action(user),
       user_test_sms_action(user),
       impersonate_action(user)]
    end

    def impersonate_action(user)
      return unless policy(user).impersonate?

      link_to icon(:user, 'Sign In As'),
              "/rad_common/impersonations/start?id=#{user.id}",
              method: :post,
              data: { confirm: 'Sign in as this user? Note that any audit trail records will still be associated to '\
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
      return unless Devise.mappings[:user].confirmable? && policy(user).update? && !user.confirmed?

      confirm = "This will manually confirm the user's email address and bypass this verification step. Are you sure?"
      link_to icon(:check, 'Confirm Email'),
              "/rad_common/users/#{user.id}/confirm",
              method: :put,
              data: { confirm: confirm },
              class: 'btn btn-warning btn-sm'
    end

    def user_resend_action(user)
      return unless policy(User.new).create? && user.invitation_sent_at.present? && user.invitation_accepted_at.blank?

      link_to 'Resend Invitation',
              "/rad_common/users/#{user.id}/resend_invitation",
              method: :put,
              class: 'btn btn-sm btn-success',
              data: { confirm: 'Are you sure?' }
    end

    def user_reset_authy_action(user)
      return unless RadicalConfig.authy_enabled? && policy(user).update? && user.authy_enabled?

      confirm = "This will reset the user's two factor authentication configuration if they are having problems. "\
                'Are you sure?'

      link_to icon(:refresh, 'Reset Two Factor'),
              "/rad_common/users/#{user.id}/reset_authy",
              method: :put,
              data: { confirm: confirm },
              class: 'btn btn-warning btn-sm'
    end

    def user_test_email_action(user)
      return unless policy(user).test_email?

      link_to icon(:envelope, 'Send Test Email'),
              "/rad_common/users/#{user.id}/test_email",
              method: :put,
              class: 'btn btn-secondary btn-sm',
              data: { confirm: 'Are you sure?' }
    end

    def user_test_sms_action(user)
      return unless RadicalTwilio.new.twilio_enabled? && user.mobile_phone.present? && policy(user).test_sms?

      link_to icon(:comments, 'Send Test SMS'),
              "/rad_common/users/#{user.id}/test_sms",
              method: :put,
              class: 'btn btn-secondary btn-sm',
              data: { confirm: 'Are you sure?' }
    end

    def export_users_button(user_search)
      link_to 'Export to File',
              users_path(search: user_search.search_params, format: :csv),
              class: 'btn btn-sm btn-secondary'
    end
  end
end
