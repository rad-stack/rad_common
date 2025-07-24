module Pace
  class RelatedInventoryItems < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :to_inventory_item

    attr_accessor :from_inventory_item


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'to_inventory_item' => :'toInventoryItem',
        :'from_inventory_item' => :'fromInventoryItem'
      }
    end
  end
end
