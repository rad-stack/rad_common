module Pace
  class UserDefinedMenu < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :results

    attr_accessor :group

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :created_by

    attr_accessor :webapp

    attr_accessor :date_created


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'results' => :'results',
        :'group' => :'group',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'created_by' => :'createdBy',
        :'webapp' => :'webapp',
        :'date_created' => :'dateCreated'
      }
    end
  end
end
