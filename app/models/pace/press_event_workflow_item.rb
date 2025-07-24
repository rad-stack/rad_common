module Pace
  class PressEventWorkflowItem < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :press_event

    attr_accessor :device_capability

    attr_accessor :press_event_workflow


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'press_event' => :'pressEvent',
        :'device_capability' => :'deviceCapability',
        :'press_event_workflow' => :'pressEventWorkflow'
      }
    end
  end
end
