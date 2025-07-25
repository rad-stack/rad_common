module Pace
  class MetropolitanArea < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :country

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :state_key

    attr_accessor :zip

    attr_accessor :city

    attr_accessor :address3

    attr_accessor :address2

    attr_accessor :address1

    attr_accessor :latitude

    attr_accessor :manual_location

    attr_accessor :state_code

    attr_accessor :radius

    attr_accessor :longitude


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'country' => :'country',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'state_key' => :'stateKey',
        :'zip' => :'zip',
        :'city' => :'city',
        :'address3' => :'address3',
        :'address2' => :'address2',
        :'address1' => :'address1',
        :'latitude' => :'latitude',
        :'manual_location' => :'manualLocation',
        :'state_code' => :'stateCode',
        :'radius' => :'radius',
        :'longitude' => :'longitude'
      }
    end
  end
end
