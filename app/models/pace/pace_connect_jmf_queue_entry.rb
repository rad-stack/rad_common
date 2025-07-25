module Pace
  class PaceConnectJMFQueueEntry < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :data_object

    attr_accessor :pace_connect

    attr_accessor :queue_entry_id


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'data_object' => :'dataObject',
        :'pace_connect' => :'paceConnect',
        :'queue_entry_id' => :'queueEntryID'
      }
    end
  end
end
