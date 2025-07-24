module Pace
  class ExternalBODPrimaryKeyReference < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :object_name

    attr_accessor :epace_primary_key

    attr_accessor :scheme_agency_id

    attr_accessor :external_primary_key


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'object_name' => :'objectName',
        :'epace_primary_key' => :'epacePrimaryKey',
        :'scheme_agency_id' => :'schemeAgencyID',
        :'external_primary_key' => :'externalPrimaryKey'
      }
    end
  end
end
