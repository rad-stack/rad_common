module Pace
  class EstimateCompositeProduct < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :production_type

    attr_accessor :user_interface_set

    attr_accessor :manufacturing_locations

    attr_accessor :repetitive_runs


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'production_type' => :'productionType',
        :'user_interface_set' => :'userInterfaceSet',
        :'manufacturing_locations' => :'manufacturingLocations',
        :'repetitive_runs' => :'repetitiveRuns'
      }
    end
  end
end
