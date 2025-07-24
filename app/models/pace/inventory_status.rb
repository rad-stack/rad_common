module Pace
  class InventoryStatus < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :code

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :status_type

    attr_accessor :available_in_ecommerce

    attr_accessor :available_for_fulfillment

    attr_accessor :available_for_fiery

    attr_accessor :available_for_reporting


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'code' => :'code',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'status_type' => :'statusType',
        :'available_in_ecommerce' => :'availableInEcommerce',
        :'available_for_fulfillment' => :'availableForFulfillment',
        :'available_for_fiery' => :'availableForFiery',
        :'available_for_reporting' => :'availableForReporting'
      }
    end
  end
end
