module Pace
  class RoutingTemplate < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :combo_binding_method

    attr_accessor :combo_template

    attr_accessor :combo_prepress_workflow


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'combo_binding_method' => :'comboBindingMethod',
        :'combo_template' => :'comboTemplate',
        :'combo_prepress_workflow' => :'comboPrepressWorkflow'
      }
    end
  end
end
