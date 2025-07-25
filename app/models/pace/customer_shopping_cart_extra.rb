module Pace
  class CustomerShoppingCartExtra < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :customer

    attr_accessor :shopping_cart_extra_template


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'customer' => :'customer',
        :'shopping_cart_extra_template' => :'shoppingCartExtraTemplate'
      }
    end
  end
end
