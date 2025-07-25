module Pace
  class EventHandlerDefinition < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_generated

    attr_accessor :pace_connect_generated

    attr_accessor :created_by

    attr_accessor :date_created

    attr_accessor :default_state


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'system_generated' => :'systemGenerated',
        :'pace_connect_generated' => :'paceConnectGenerated',
        :'created_by' => :'createdBy',
        :'date_created' => :'dateCreated',
        :'default_state' => :'defaultState'
      }
    end
  end
end
