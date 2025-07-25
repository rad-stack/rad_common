module Pace
  class PaceConnectPendingFile < Base
    attr_accessor :key

    attr_accessor :id

    attr_accessor :url

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job

    attr_accessor :note

    attr_accessor :pace_connect

    attr_accessor :received_date_time


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'key' => :'key',
        :'id' => :'id',
        :'url' => :'url',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job' => :'job',
        :'note' => :'note',
        :'pace_connect' => :'paceConnect',
        :'received_date_time' => :'receivedDateTime'
      }
    end
  end
end
