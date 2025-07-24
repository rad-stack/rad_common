module Pace
  class EventHandlerEmailConsequenceDefinition < Base
    attr_accessor :name

    attr_accessor :priority

    attr_accessor :id

    attr_accessor :handler

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_generated

    attr_accessor :pace_connect_generated

    attr_accessor :save_sent_email

    attr_accessor :allow_save_sent_email

    attr_accessor :exclude_initiator

    attr_accessor :template


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'priority' => :'priority',
        :'id' => :'id',
        :'handler' => :'handler',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'system_generated' => :'systemGenerated',
        :'pace_connect_generated' => :'paceConnectGenerated',
        :'save_sent_email' => :'saveSentEmail',
        :'allow_save_sent_email' => :'allowSaveSentEmail',
        :'exclude_initiator' => :'excludeInitiator',
        :'template' => :'template'
      }
    end
  end
end
