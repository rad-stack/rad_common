module Pace
  class PriceDetail < Base
    attr_accessor :id

    attr_accessor :line_number

    attr_accessor :weight

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :quantity

    attr_accessor :price

    attr_accessor :flat_price

    attr_accessor :run_price


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'line_number' => :'lineNumber',
        :'weight' => :'weight',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'quantity' => :'quantity',
        :'price' => :'price',
        :'flat_price' => :'flatPrice',
        :'run_price' => :'runPrice'
      }
    end
  end
end
