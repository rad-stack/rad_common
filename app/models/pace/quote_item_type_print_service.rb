module Pace
  class QuoteItemTypePrintService < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :default_option

    attr_accessor :quote_item_type

    attr_accessor :quote_item_type_inventory_item

    attr_accessor :print_service


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'default_option' => :'defaultOption',
        :'quote_item_type' => :'quoteItemType',
        :'quote_item_type_inventory_item' => :'quoteItemTypeInventoryItem',
        :'print_service' => :'printService'
      }
    end
  end
end
