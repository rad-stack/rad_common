module Pace
  class UserForm < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :data_object

    attr_accessor :created_by

    attr_accessor :webapp

    attr_accessor :date_created

    attr_accessor :form_xml

    attr_accessor :form_name


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'data_object' => :'dataObject',
        :'created_by' => :'createdBy',
        :'webapp' => :'webapp',
        :'date_created' => :'dateCreated',
        :'form_xml' => :'formXML',
        :'form_name' => :'formName'
      }
    end
  end
end
