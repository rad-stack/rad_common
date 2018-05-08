module RadCommon
  module SecurityRoleHelper
    def humanized_permission_fields
      SecurityRole.permission_fields.each_with_object([]) do |field, permissions|
        label = humanized_permission_field(field)
        permissions.push(label: label, permission: field)
      end
    end

    def humanized_permission_field(field)
      field.titleize.pluralize.gsub('Admins', 'Administration').gsub('Read', 'View')
    end

    def normalize_names(fields)
      security_role_hash = {}

      fields.each do |field|
        name = normalize_name(field[:label])
        security_role_hash[name] = field[:permission]
      end

      security_role_hash.sort
    end

    def normalize_name(label)
      if label.include? 'Manage '
        label.sub 'Manage', 'Manage (View, Edit, Create, Delete)'
      elsif label.include? 'Update'
        label.sub 'Update', 'Edit'
      else
        label
      end
    end

    def security_role_collection
      SecurityRole.all.map { |role| [role.name, role.id] }
    end
  end
end
