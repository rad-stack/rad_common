module Pace
  class PaceConnectFieldMigration < Base
    attr_accessor :field

    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :pace_connect_object_migration


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'field' => :'field',
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'pace_connect_object_migration' => :'paceConnectObjectMigration'
      }
    end
  end
end
