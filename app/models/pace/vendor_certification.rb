module Pace
  class VendorCertification < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :certification_authority

    attr_accessor :vendor

    attr_accessor :expiration_date

    attr_accessor :certification_number

    attr_accessor :last_date


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'certification_authority' => :'certificationAuthority',
        :'vendor' => :'vendor',
        :'expiration_date' => :'expirationDate',
        :'certification_number' => :'certificationNumber',
        :'last_date' => :'lastDate'
      }
    end
  end
end
