module Pace
  class SalesCategoryTaxRate < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :country

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sales_category

    attr_accessor :sales_tax

    attr_accessor :tax_category

    attr_accessor :account


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'country' => :'country',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sales_category' => :'salesCategory',
        :'sales_tax' => :'salesTax',
        :'tax_category' => :'taxCategory',
        :'account' => :'account'
      }
    end
  end
end
