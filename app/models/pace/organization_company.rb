module Pace
  class OrganizationCompany < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :base_url

    attr_accessor :organization

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :breadcrumb_root_label

    attr_accessor :consolidate_ar

    attr_accessor :consolidate_ap

    attr_accessor :share_users

    attr_accessor :iso_currency

    attr_accessor :ap_subscriber

    attr_accessor :consolidate_gl

    attr_accessor :appliance_company_id

    attr_accessor :security_subscriber

    attr_accessor :ar_subscriber

    attr_accessor :gl_subscriber


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'base_url' => :'baseURL',
        :'organization' => :'organization',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'breadcrumb_root_label' => :'breadcrumbRootLabel',
        :'consolidate_ar' => :'consolidateAR',
        :'consolidate_ap' => :'consolidateAP',
        :'share_users' => :'shareUsers',
        :'iso_currency' => :'isoCurrency',
        :'ap_subscriber' => :'apSubscriber',
        :'consolidate_gl' => :'consolidateGL',
        :'appliance_company_id' => :'applianceCompanyID',
        :'security_subscriber' => :'securitySubscriber',
        :'ar_subscriber' => :'arSubscriber',
        :'gl_subscriber' => :'glSubscriber'
      }
    end
  end
end
