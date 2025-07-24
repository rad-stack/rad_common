module Pace
  class CustomerGroup < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :code

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :revenue_ytd

    attr_accessor :ar_customer

    attr_accessor :discount

    attr_accessor :group_payments


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'code' => :'code',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'revenue_ytd' => :'revenueYTD',
        :'ar_customer' => :'arCustomer',
        :'discount' => :'discount',
        :'group_payments' => :'groupPayments'
      }
    end
  end
end
