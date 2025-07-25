module Pace
  class ShoppingCartExtra < Base
    attr_accessor :priority

    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :amount

    attr_accessor :total_price

    attr_accessor :shopping_cart

    attr_accessor :tax

    attr_accessor :shopping_cart_extra_template


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'priority' => :'priority',
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'amount' => :'amount',
        :'total_price' => :'totalPrice',
        :'shopping_cart' => :'shoppingCart',
        :'tax' => :'tax',
        :'shopping_cart_extra_template' => :'shoppingCartExtraTemplate'
      }
    end
  end
end
