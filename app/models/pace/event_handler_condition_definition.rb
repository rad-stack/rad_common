module Pace
  class EventHandlerConditionDefinition < Base
    attr_accessor :id

    attr_accessor :type

    attr_accessor :expression

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_generated

    attr_accessor :pace_connect_generated

    attr_accessor :event


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'type' => :'type',
        :'expression' => :'expression',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'system_generated' => :'systemGenerated',
        :'pace_connect_generated' => :'paceConnectGenerated',
        :'event' => :'event'
      }
    end
  end
end
