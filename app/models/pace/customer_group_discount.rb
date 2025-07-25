module Pace
  class CustomerGroupDiscount < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :discount_percent

    attr_accessor :customer_group

    attr_accessor :revenue_level_high

    attr_accessor :revenue_level_low


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'discount_percent' => :'discountPercent',
        :'customer_group' => :'customerGroup',
        :'revenue_level_high' => :'revenueLevelHigh',
        :'revenue_level_low' => :'revenueLevelLow'
      }
    end
  end
end
