module Pace
  class RoutingTemplateOrder < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :cost_center

    attr_accessor :allow_dynamic_route_calculation

    attr_accessor :combo

    attr_accessor :routing_template


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'cost_center' => :'costCenter',
        :'allow_dynamic_route_calculation' => :'allowDynamicRouteCalculation',
        :'combo' => :'combo',
        :'routing_template' => :'routingTemplate'
      }
    end
  end
end
