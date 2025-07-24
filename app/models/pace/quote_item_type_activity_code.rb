module Pace
  class QuoteItemTypeActivityCode < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :activity_code

    attr_accessor :quote_item_type

    attr_accessor :make_ready

    attr_accessor :production_unit_calculation

    attr_accessor :time_calculation

    attr_accessor :estimating


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'activity_code' => :'activityCode',
        :'quote_item_type' => :'quoteItemType',
        :'make_ready' => :'makeReady',
        :'production_unit_calculation' => :'productionUnitCalculation',
        :'time_calculation' => :'timeCalculation',
        :'estimating' => :'estimating'
      }
    end
  end
end
