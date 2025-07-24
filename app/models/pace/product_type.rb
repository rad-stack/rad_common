module Pace
  class ProductType < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :customer_group

    attr_accessor :item_template

    attr_accessor :customer

    attr_accessor :job_product_type

    attr_accessor :estimate_product_category

    attr_accessor :ask_quantity_multiplier

    attr_accessor :product_name

    attr_accessor :quick_copy_type

    attr_accessor :product_price


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'customer_group' => :'customerGroup',
        :'item_template' => :'itemTemplate',
        :'customer' => :'customer',
        :'job_product_type' => :'jobProductType',
        :'estimate_product_category' => :'estimateProductCategory',
        :'ask_quantity_multiplier' => :'askQuantityMultiplier',
        :'product_name' => :'productName',
        :'quick_copy_type' => :'quickCopyType',
        :'product_price' => :'productPrice'
      }
    end
  end
end
