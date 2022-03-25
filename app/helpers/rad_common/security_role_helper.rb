module RadCommon
  module SecurityRoleHelper
    def humanized_permission_fields
      SecurityRole.permission_fields.each_with_object([]) do |field, permissions|
        label = humanized_permission_field(field)
        permissions.push(label: label, permission: field)
      end
    end

    def humanized_permission_field(field)
      field.titleize
    end

    def normalize_names(fields)
      security_role_hash = {}

      fields.each do |field|
        security_role_hash[field[:label]] = field[:permission]
      end

      security_role_hash.sort
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

    def permission_tooltip(permission)
      RadPermission.new(permission).tooltip
    end

    def permission_tooltip_content(permission)
      return if permission_tooltip(permission).blank?

      tag.i('',
            class: 'fa fa-question-circle custom-tooltip tooltip-pad mr-2',
            'data-toggle': 'tooltip',
            title: permission_tooltip(permission))
    end
  end
end
