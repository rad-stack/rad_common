module Pace
  class WorkstationNonChargeableType < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :workstation

    attr_accessor :non_chargeable_type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'workstation' => :'workstation',
        :'non_chargeable_type' => :'nonChargeableType'
      }
    end
  end
end
