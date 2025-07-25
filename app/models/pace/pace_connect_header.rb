module Pace
  class PaceConnectHeader < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :pace_connect

    attr_accessor :header_name

    attr_accessor :header_value


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'pace_connect' => :'paceConnect',
        :'header_name' => :'headerName',
        :'header_value' => :'headerValue'
      }
    end
  end
end
