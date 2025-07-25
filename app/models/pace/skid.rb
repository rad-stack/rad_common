module Pace
  class Skid < Base
    attr_accessor :id

    attr_accessor :count

    attr_accessor :description

    attr_accessor :weight

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_shipment


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'count' => :'count',
        :'description' => :'description',
        :'weight' => :'weight',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_shipment' => :'jobShipment'
      }
    end
  end
end
