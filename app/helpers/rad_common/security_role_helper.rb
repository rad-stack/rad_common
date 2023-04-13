module RadCommon
  module SecurityRoleHelper
    def security_role_show_data
      items = [:external]
      items += [:allow_invite] unless RadConfig.disable_invite?
      items += [:allow_sign_up] unless RadConfig.disable_sign_up?
      items
    end

    def security_role_collection(mode)
      roles = SecurityRole

      case mode
      when :internal
        roles = roles.internal
      when :external
        roles = roles.external
      end

      roles.by_name.map { |role| [role.name, role.id] }
    end

    def permission_tooltip_content(tooltip)
      return if tooltip.blank?

      tag.i('',
            class: 'fa fa-circle-question custom-tooltip tooltip-pad mr-2 align-self-center',
            'data-toggle': 'tooltip',
            title: tooltip)
    end
  end
end
