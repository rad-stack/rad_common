module Pace
  class PaceConnectObjectMigration < Base
    attr_accessor :id

    attr_accessor :object

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :pace_connect

    attr_accessor :allow_partially_synced_fields

    attr_accessor :allow_partially_synced_fields_for_new_objects


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'object' => :'object',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'pace_connect' => :'paceConnect',
        :'allow_partially_synced_fields' => :'allowPartiallySyncedFields',
        :'allow_partially_synced_fields_for_new_objects' => :'allowPartiallySyncedFieldsForNewObjects'
      }
    end
  end
end
