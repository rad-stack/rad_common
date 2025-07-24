module Pace
  class ProductItem < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :sequence

    attr_accessor :quote_item_type

    attr_accessor :quote_item_type_inventory_item

    attr_accessor :quantity_multiplier

    attr_accessor :quote_item_type_print_service

    attr_accessor :product_type

    attr_accessor :default_item

    attr_accessor :quick_copy_option


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
        :'quote_item_type' => :'quoteItemType',
        :'quote_item_type_inventory_item' => :'quoteItemTypeInventoryItem',
        :'quantity_multiplier' => :'quantityMultiplier',
        :'quote_item_type_print_service' => :'quoteItemTypePrintService',
        :'product_type' => :'productType',
        :'default_item' => :'defaultItem',
        :'quick_copy_option' => :'quickCopyOption'
      }
    end
  end
end
