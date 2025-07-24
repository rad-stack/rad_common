module Pace
  class InstallationToolChecklist < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_shipment

    attr_accessor :installation_tool

    attr_accessor :installation_tool_category


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_shipment' => :'jobShipment',
        :'installation_tool' => :'installationTool',
        :'installation_tool_category' => :'installationToolCategory'
      }
    end
  end
end
