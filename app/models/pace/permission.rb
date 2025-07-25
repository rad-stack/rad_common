module Pace
  class Permission < Base
    attr_accessor :name

    attr_accessor :actions

    attr_accessor :id

    attr_accessor :permission

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :group_name


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'actions' => :'actions',
        :'id' => :'id',
        :'permission' => :'permission',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'group_name' => :'groupName'
      }
    end
  end
end
