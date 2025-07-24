module Pace
  class EstimateRequestPressEvent < Base
    attr_accessor :id

    attr_accessor :state

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :press_event

    attr_accessor :finishing_operation

    attr_accessor :estimate_request_part


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'state' => :'state',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'press_event' => :'pressEvent',
        :'finishing_operation' => :'finishingOperation',
        :'estimate_request_part' => :'estimateRequestPart'
      }
    end
  end
end
