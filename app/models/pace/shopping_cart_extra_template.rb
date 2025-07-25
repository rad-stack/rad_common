module Pace
  class ShoppingCartExtraTemplate < Base
    attr_accessor :value

    attr_accessor :priority

    attr_accessor :id

    attr_accessor :enabled

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :charge_type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'value' => :'value',
        :'priority' => :'priority',
        :'id' => :'id',
        :'enabled' => :'enabled',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'charge_type' => :'chargeType'
      }
    end
  end
end
