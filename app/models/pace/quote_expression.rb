module Pace
  class QuoteExpression < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :expression

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :calculation_type

    attr_accessor :job_part_item_expression

    attr_accessor :estimate_expression


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'expression' => :'expression',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'calculation_type' => :'calculationType',
        :'job_part_item_expression' => :'jobPartItemExpression',
        :'estimate_expression' => :'estimateExpression'
      }
    end
  end
end
