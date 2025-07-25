module Pace
  class QuoteCalcMessage < Base
    attr_accessor :message

    attr_accessor :id

    attr_accessor :severity

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :quote

    attr_accessor :created_date_time

    attr_accessor :created_by

    attr_accessor :quote_item

    attr_accessor :quote_quantity

    attr_accessor :quote_product


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'message' => :'message',
        :'id' => :'id',
        :'severity' => :'severity',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'quote' => :'quote',
        :'created_date_time' => :'createdDateTime',
        :'created_by' => :'createdBy',
        :'quote_item' => :'quoteItem',
        :'quote_quantity' => :'quoteQuantity',
        :'quote_product' => :'quoteProduct'
      }
    end
  end
end
