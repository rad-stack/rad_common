module Pace
  class EventHandlerEventDefinition < Base
    attr_accessor :id

    attr_accessor :type

    attr_accessor :handler

    attr_accessor :source

    attr_accessor :identifier

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_generated

    attr_accessor :pace_connect_generated


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'type' => :'type',
        :'handler' => :'handler',
        :'source' => :'source',
        :'identifier' => :'identifier',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'system_generated' => :'systemGenerated',
        :'pace_connect_generated' => :'paceConnectGenerated'
      }
    end
  end
end
