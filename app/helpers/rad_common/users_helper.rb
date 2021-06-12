module RadCommon
  module UsersHelper
    def user_show_data(user)
      items = %i[email mobile_phone user_status timezone sign_in_count invitation_accepted_at invited_by]
      items.push(:authy_id) if Rails.application.credentials.authy_api_key.present?
      items += %i[current_sign_in_ip current_sign_in_at confirmed_at confirmation_sent_at unconfirmed_email]
      items.push(:last_activity_at) if user.respond_to?(:last_activity_at)

      if RadCommon.use_avatar && user.avatar.attached?
        items.push(label: 'Avatar',
                   value: render('layouts/attachment', record: user, attachment_name: 'avatar', new_tab: true))
      end

      items
    end

    def users_actions
      return unless policy(User.new).new?

      [link_to(icon('plus-square', 'Invite User'), new_user_invitation_path, class: 'btn btn-success btn-sm')]
    end

    def user_actions(user)
      [user_confirm_action(user), user_reset_authy_action(user)]
    end

    def user_confirm_action(user)
      return unless policy(user).update? && !user.confirmed?

      confirm = "This will manually confirm the user's email address and bypass this verification step. Are you sure?"
      link_to icon(:check, 'Confirm Email'), confirm_user_path(user), method: :put,
                                                                      data: { confirm: confirm },
                                                                      class: 'btn btn-warning btn-sm'
    end

    def user_reset_authy_action(user)
      return unless policy(user).update? && user.authy_enabled?

      confirm = "This will reset the user's two factor authentication configuration if they are having problems. "\
                'Are you sure?'

      link_to icon(:refresh, 'Reset Two Factor'), reset_authy_user_path(user), method: :put,
                                                                               data: { confirm: confirm },
                                                                               class: 'btn btn-warning btn-sm'
    end

    def export_users_button(user_search)
      link_to 'Export to File',
              users_path(search: user_search.search_params, format: :csv),
              class: 'btn btn-sm btn-secondary'
    end
  end
end
