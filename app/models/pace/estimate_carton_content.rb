module Pace
  class EstimateCartonContent < Base
    attr_accessor :value

    attr_accessor :id

    attr_accessor :type

    attr_accessor :versions

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :note

    attr_accessor :estimate_part

    attr_accessor :estimate_quantity

    attr_accessor :estimate_product

    attr_accessor :carton

    attr_accessor :estimate

    attr_accessor :total_number_of_cartons

    attr_accessor :estimate_material

    attr_accessor :ship_line_correlation_id

    attr_accessor :quantity_per_carton

    attr_accessor :residual_qty

    attr_accessor :total_weight


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'value' => :'value',
        :'id' => :'id',
        :'type' => :'type',
        :'versions' => :'versions',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'note' => :'note',
        :'estimate_part' => :'estimatePart',
        :'estimate_quantity' => :'estimateQuantity',
        :'estimate_product' => :'estimateProduct',
        :'carton' => :'carton',
        :'estimate' => :'estimate',
        :'total_number_of_cartons' => :'totalNumberOfCartons',
        :'estimate_material' => :'estimateMaterial',
        :'ship_line_correlation_id' => :'shipLineCorrelationId',
        :'quantity_per_carton' => :'quantityPerCarton',
        :'residual_qty' => :'residualQty',
        :'total_weight' => :'totalWeight'
      }
    end
  end
end
