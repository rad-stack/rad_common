module Pace
  class Revision < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :inventory_item

    attr_accessor :qty_uom

    attr_accessor :qty_on_hand

    attr_accessor :revision_num

    attr_accessor :average_cost

    attr_accessor :total_qty_produced

    attr_accessor :total_qty_remaining

    attr_accessor :revision_price

    attr_accessor :max_qty


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
        :'sequence' => :'sequence',
        :'inventory_item' => :'inventoryItem',
        :'qty_uom' => :'qtyUom',
        :'qty_on_hand' => :'qtyOnHand',
        :'revision_num' => :'revisionNum',
        :'average_cost' => :'averageCost',
        :'total_qty_produced' => :'totalQtyProduced',
        :'total_qty_remaining' => :'totalQtyRemaining',
        :'revision_price' => :'revisionPrice',
        :'max_qty' => :'maxQty'
      }
    end
  end
end
