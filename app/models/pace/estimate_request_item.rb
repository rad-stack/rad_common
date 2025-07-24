module Pace
  class EstimateRequestItem < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :item_template

    attr_accessor :customer_viewable

    attr_accessor :estimate_request_part

    attr_accessor :quote_item_type

    attr_accessor :quote_item_type_inventory_item


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'item_template' => :'itemTemplate',
        :'customer_viewable' => :'customerViewable',
        :'estimate_request_part' => :'estimateRequestPart',
        :'quote_item_type' => :'quoteItemType',
        :'quote_item_type_inventory_item' => :'quoteItemTypeInventoryItem'
      }
    end
  end
end
