module Pace
  class ApprovalGroup < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :purchasing_limit

    attr_accessor :purchasing_approver

    attr_accessor :purchasing_limit_currency_alt


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'purchasing_limit' => :'purchasingLimit',
        :'purchasing_approver' => :'purchasingApprover',
        :'purchasing_limit_currency_alt' => :'purchasingLimitCurrencyAlt'
      }
    end
  end
end
