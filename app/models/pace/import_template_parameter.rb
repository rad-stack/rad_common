module Pace
  class ImportTemplateParameter < Base
    attr_accessor :id

    attr_accessor :type

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :base_object

    attr_accessor :prompt

    attr_accessor :import_template

    attr_accessor :param_name

    attr_accessor :param_value


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'type' => :'type',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'base_object' => :'baseObject',
        :'prompt' => :'prompt',
        :'import_template' => :'importTemplate',
        :'param_name' => :'paramName',
        :'param_value' => :'paramValue'
      }
    end
  end
end
