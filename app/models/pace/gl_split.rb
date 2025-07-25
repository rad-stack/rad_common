module Pace
  class GLSplit < Base
    attr_accessor :id

    attr_accessor :percent

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :parent_account

    attr_accessor :split_account


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'percent' => :'percent',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'gl_department' => :'glDepartment',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'parent_account' => :'parentAccount',
        :'split_account' => :'splitAccount'
      }
    end
  end
end
