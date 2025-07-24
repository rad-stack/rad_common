module Pace
  class PaceConnectDatabaseConnection < Base
    attr_accessor :id

    attr_accessor :port

    attr_accessor :description

    attr_accessor :user_name

    attr_accessor :password

    attr_accessor :server

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :database_type

    attr_accessor :database_name


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'port' => :'port',
        :'description' => :'description',
        :'user_name' => :'userName',
        :'password' => :'password',
        :'server' => :'server',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'database_type' => :'databaseType',
        :'database_name' => :'databaseName'
      }
    end
  end
end
