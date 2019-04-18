module RadCommon
  module UsersHelper
    def user_show_data(user)
      items = %i[email mobile_phone user_status sign_in_count invitation_accepted_at invited_by]
      items.push(:authy_id) if ENV['AUTHY_API_KEY'].present?
      items += %i[current_sign_in_ip current_sign_in_at confirmed_at]
      items.push(:super_admin) if user.internal?
      items.push(:last_activity_at) if user.respond_to?(:last_activity_at)
      items
    end

    def users_actions
      return unless current_user.can_create?(User)

      content = content_tag(:it, '', class: 'fa fa-plus-square right-5px') + 'Invite User'
      [link_to(content, new_user_invitation_path, class: 'btn btn-success btn-sm')]
    end

    def user_actions(user)
      [user_confirm_action(user), user_reset_authy_action(user)]
    end

    def user_confirm_action(user)
      return unless current_user.can_update?(User) && current_user.can_update?(user) && !user.confirmed?

      content = content_tag(:it, '', class: 'fa fa-check right-5px') + 'Confirm Email'
      confirm = "This will manually confirm the user's email address and bypass this verification step. Are you sure?"
      link_to content, confirm_user_path(@user), method: :put,
                                                 data: { confirm: confirm },
                                                 class: 'btn btn-warning btn-sm'
    end

    def user_reset_authy_action(user)
      return unless current_user.can_update?(User) && current_user.can_update?(user) && user.authy_enabled?

      content = content_tag(:it, '', class: 'fa fa-refresh right-5px') + 'Reset Two Factor'

      confirm = "This will reset the user's two factor authentication configuration if they are having problems. "\
                'Are you sure?'

      link_to content, reset_authy_user_path(@user), method: :put,
                                                     data: { confirm: confirm },
                                                     class: 'btn btn-warning btn-sm'
    end
  end
end
