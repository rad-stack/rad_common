module Pace
  class InventoryLocation < Base
    attr_accessor :state

    attr_accessor :active

    attr_accessor :country

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :code

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :state_key

    attr_accessor :phone_number

    attr_accessor :zip

    attr_accessor :city

    attr_accessor :manufacturing_location

    attr_accessor :address3

    attr_accessor :address2

    attr_accessor :address1

    attr_accessor :default_bin

    attr_accessor :default_inventory_bin_key

    attr_accessor :eservice_available


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'state' => :'state',
        :'active' => :'active',
        :'country' => :'country',
        :'description' => :'description',
        :'tags' => :'tags',
        :'code' => :'code',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'state_key' => :'stateKey',
        :'phone_number' => :'phoneNumber',
        :'zip' => :'zip',
        :'city' => :'city',
        :'manufacturing_location' => :'manufacturingLocation',
        :'address3' => :'address3',
        :'address2' => :'address2',
        :'address1' => :'address1',
        :'default_bin' => :'defaultBin',
        :'default_inventory_bin_key' => :'defaultInventoryBinKey',
        :'eservice_available' => :'eserviceAvailable'
      }
    end
  end
end
