module Pace
  class PaceConnectFailedOutput < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :pace_connect_location

    attr_accessor :pace_connect_result


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'pace_connect_location' => :'paceConnectLocation',
        :'pace_connect_result' => :'paceConnectResult'
      }
    end
  end
end
