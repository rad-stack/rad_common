module RadCommon
  module UsersHelper
    def user_show_data(user)
      items = %i[email mobile_phone user_status sign_in_count]
      items.push(:authy_id) if ENV['AUTHY_API_KEY'].present?
      items += %i[current_sign_in_ip current_sign_in_at confirmed_at]
      items.push(:super_admin) if user.internal?
      items.push(:last_activity_at) if user.respond_to?(:last_activity_at)
      items
    end

    def user_actions
      return unless current_user.can_create?(User)

      content = content_tag(:it, '', class: 'fa fa-plus-square right-5px') + 'Invite User'
      [link_to(content, new_user_invitation_path, class: 'btn btn-success btn-sm')]
    end
  end
end
