module Pace
  class ImportControl < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :type

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :base_object

    attr_accessor :import_template

    attr_accessor :ignore_if_empty

    attr_accessor :control_name

    attr_accessor :control_value


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'type' => :'type',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'base_object' => :'baseObject',
        :'import_template' => :'importTemplate',
        :'ignore_if_empty' => :'ignoreIfEmpty',
        :'control_name' => :'controlName',
        :'control_value' => :'controlValue'
      }
    end
  end
end
