module Pace
  class PrepressWorkflow < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :pace_connect_production_method

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :manufacturing_locations

    attr_accessor :alt_description

    attr_accessor :material_provided

    attr_accessor :allow_empty

    attr_accessor :prep_bindery_only

    attr_accessor :prep_method


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'pace_connect_production_method' => :'paceConnectProductionMethod',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'manufacturing_locations' => :'manufacturingLocations',
        :'alt_description' => :'altDescription',
        :'material_provided' => :'materialProvided',
        :'allow_empty' => :'allowEmpty',
        :'prep_bindery_only' => :'prepBinderyOnly',
        :'prep_method' => :'prepMethod'
      }
    end
  end
end
