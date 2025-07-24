module Pace
  class ItemTemplateQuantity < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :item_template

    attr_accessor :estimate_quantity

    attr_accessor :quote_quantity

    attr_accessor :up_to_quantity


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'item_template' => :'itemTemplate',
        :'estimate_quantity' => :'estimateQuantity',
        :'quote_quantity' => :'quoteQuantity',
        :'up_to_quantity' => :'upToQuantity'
      }
    end
  end
end
