module Pace
  class SubProductGroup < Base
    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :primary_key

    attr_accessor :product_group

    attr_accessor :sub_product_group


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'primary_key' => :'primaryKey',
        :'product_group' => :'productGroup',
        :'sub_product_group' => :'subProductGroup'
      }
    end
  end
end
