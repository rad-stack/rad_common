module Pace
  class ShipZone < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :state

    attr_accessor :country

    attr_accessor :provider

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :state_key


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'state' => :'state',
        :'country' => :'country',
        :'provider' => :'provider',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'state_key' => :'stateKey'
      }
    end
  end
end
