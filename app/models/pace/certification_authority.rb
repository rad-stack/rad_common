module Pace
  class CertificationAuthority < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :manager

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :certification_authority

    attr_accessor :certification_num

    attr_accessor :reporting_certification

    attr_accessor :scope_statement


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'manager' => :'manager',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'certification_authority' => :'certificationAuthority',
        :'certification_num' => :'certificationNum',
        :'reporting_certification' => :'reportingCertification',
        :'scope_statement' => :'scopeStatement'
      }
    end
  end
end
