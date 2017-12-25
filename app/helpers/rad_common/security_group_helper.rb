module RadCommon
  module SecurityGroupHelper
    def humanized_permission_fields
      SecurityGroup.permission_fields.each_with_object([]) do |field, permissions|
        label = field.titleize.pluralize.gsub("Admins", "Administration").gsub("Read", "View")
        permissions.push({ label: label, permission: field})
      end
    end

    def normalize_name(fields)
      security_group_hash = Hash.new
      fields.each do |field|
        name = if field[:label].include? 'Manage'
          field[:label].sub 'Manage', 'Manage (View, Edit, Create, Delete)'
        elsif field[:label].include? 'Update'
          field[:label].sub 'Update', 'Edit'
        else
          field[:label]
        end
        security_group_hash[name] = field[:permission]
      end
      security_group_hash.sort
    end
  end
end
