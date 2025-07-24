module Pace
  class EstimateRequestMaterial < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :quantity

    attr_accessor :inventory_item

    attr_accessor :vendor

    attr_accessor :estimate_request_part

    attr_accessor :fktag_inventoryitem


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'quantity' => :'quantity',
        :'inventory_item' => :'inventoryItem',
        :'vendor' => :'vendor',
        :'estimate_request_part' => :'estimateRequestPart',
        :'fktag_inventoryitem' => :'fktag_inventoryitem'
      }
    end
  end
end
