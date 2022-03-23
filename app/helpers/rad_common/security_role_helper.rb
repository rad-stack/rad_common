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

      security_role_hash
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
      t "permission_tooltips.#{permission}", default: permission_tooltip_default(permission)
    end

    def permission_tooltip_default(permission)
      if permission.start_with?('create_')
        suffix = permission.gsub('create_', '').titleize.pluralize.downcase
        "Create new #{suffix}"
      elsif permission.start_with?('read_')
        suffix = permission.gsub('read_', '').titleize.pluralize.downcase
        "Read #{suffix}"
      elsif permission.start_with?('update_')
        suffix = permission.gsub('update_', '').titleize.pluralize.downcase
        "Update existing #{suffix}"
      elsif permission.start_with?('edit_')
        suffix = permission.gsub('edit_', '').titleize.pluralize.downcase
        "Update existing #{suffix}"
      elsif permission.start_with?('destroy_')
        suffix = permission.gsub('destroy_', '').titleize.pluralize.downcase
        "Delete #{suffix}"
      elsif permission.start_with?('delete_')
        suffix = permission.gsub('delete_', '').titleize.pluralize.downcase
        "Delete #{suffix}"
      elsif permission.start_with?('manage_')
        suffix = permission.gsub('manage_', '').titleize.pluralize.downcase
        "Manage (read/create/update/delete) #{suffix}"
      else
        ''
      end
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
