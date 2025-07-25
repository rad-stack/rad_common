module Pace
  class QuoteItem < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :sequence

    attr_accessor :material_vendor

    attr_accessor :product

    attr_accessor :quote_item_type

    attr_accessor :quote_item_type_inventory_item

    attr_accessor :quantity_override

    attr_accessor :quantity_multiplier

    attr_accessor :removable

    attr_accessor :quantity_value

    attr_accessor :quote_item_type_print_service


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'category' => :'category',
        :'sequence' => :'sequence',
        :'material_vendor' => :'materialVendor',
        :'product' => :'product',
        :'quote_item_type' => :'quoteItemType',
        :'quote_item_type_inventory_item' => :'quoteItemTypeInventoryItem',
        :'quantity_override' => :'quantityOverride',
        :'quantity_multiplier' => :'quantityMultiplier',
        :'removable' => :'removable',
        :'quantity_value' => :'quantityValue',
        :'quote_item_type_print_service' => :'quoteItemTypePrintService'
      }
    end
  end
end
