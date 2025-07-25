module Pace
  class EstimateShipment < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :ship_via

    attr_accessor :correlation_id

    attr_accessor :quoted_price

    attr_accessor :shipment_type

    attr_accessor :contact_number

    attr_accessor :estimate

    attr_accessor :promise_date_time

    attr_accessor :shipment_line_id

    attr_accessor :total_shipment_quantity

    attr_accessor :pos

    attr_accessor :calculated_cost

    attr_accessor :shipment_line_total_shipment_quantity

    attr_accessor :total_shipment_weight

    attr_accessor :temp_calculated_cost_for_shipment_line


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'ship_via' => :'shipVia',
        :'correlation_id' => :'correlationId',
        :'quoted_price' => :'quotedPrice',
        :'shipment_type' => :'shipmentType',
        :'contact_number' => :'contactNumber',
        :'estimate' => :'estimate',
        :'promise_date_time' => :'promiseDateTime',
        :'shipment_line_id' => :'shipmentLineId',
        :'total_shipment_quantity' => :'totalShipmentQuantity',
        :'pos' => :'pos',
        :'calculated_cost' => :'calculatedCost',
        :'shipment_line_total_shipment_quantity' => :'shipmentLineTotalShipmentQuantity',
        :'total_shipment_weight' => :'totalShipmentWeight',
        :'temp_calculated_cost_for_shipment_line' => :'tempCalculatedCostForShipmentLine'
      }
    end
  end
end
