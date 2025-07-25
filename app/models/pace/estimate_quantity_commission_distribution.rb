module Pace
  class EstimateQuantityCommissionDistribution < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sales_person

    attr_accessor :amount

    attr_accessor :correlation_id

    attr_accessor :estimate_quantity

    attr_accessor :commission_rate

    attr_accessor :commission_rate_forced


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sales_person' => :'salesPerson',
        :'amount' => :'amount',
        :'correlation_id' => :'correlationId',
        :'estimate_quantity' => :'estimateQuantity',
        :'commission_rate' => :'commissionRate',
        :'commission_rate_forced' => :'commissionRateForced'
      }
    end
  end
end
