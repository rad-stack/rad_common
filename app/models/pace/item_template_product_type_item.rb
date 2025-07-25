module Pace
  class ItemTemplateProductTypeItem < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_generated

    attr_accessor :record_type

    attr_accessor :product_item

    attr_accessor :item_template_product_type

    attr_accessor :create_press_form

    attr_accessor :use_price

    attr_accessor :determination_code


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'system_generated' => :'systemGenerated',
        :'record_type' => :'recordType',
        :'product_item' => :'productItem',
        :'item_template_product_type' => :'itemTemplateProductType',
        :'create_press_form' => :'createPressForm',
        :'use_price' => :'usePrice',
        :'determination_code' => :'determinationCode'
      }
    end
  end
end
