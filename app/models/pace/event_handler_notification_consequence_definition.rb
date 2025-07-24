module Pace
  class EventHandlerNotificationConsequenceDefinition < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :handler

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_generated

    attr_accessor :start_date

    attr_accessor :pace_connect_generated

    attr_accessor :send_to_all

    attr_accessor :requires_acknowledgment

    attr_accessor :expiration_date

    attr_accessor :template


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'handler' => :'handler',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'system_generated' => :'systemGenerated',
        :'start_date' => :'startDate',
        :'pace_connect_generated' => :'paceConnectGenerated',
        :'send_to_all' => :'sendToAll',
        :'requires_acknowledgment' => :'requiresAcknowledgment',
        :'expiration_date' => :'expirationDate',
        :'template' => :'template'
      }
    end
  end
end
