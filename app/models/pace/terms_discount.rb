module Pace
  class TermsDiscount < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :discount_percent

    attr_accessor :terms

    attr_accessor :discount_day_till_due

    attr_accessor :order_period


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'discount_percent' => :'discountPercent',
        :'terms' => :'terms',
        :'discount_day_till_due' => :'discountDayTillDue',
        :'order_period' => :'orderPeriod'
      }
    end
  end
end
