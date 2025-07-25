module Pace
  class ReportEmailRecipient < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :user_name

    attr_accessor :expression

    attr_accessor :contact

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_generated

    attr_accessor :customer

    attr_accessor :include_if_expression

    attr_accessor :group_name

    attr_accessor :recipient_type

    attr_accessor :company_email

    attr_accessor :recipient

    attr_accessor :recipient_address_type

    attr_accessor :report


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'user_name' => :'userName',
        :'expression' => :'expression',
        :'contact' => :'contact',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'system_generated' => :'systemGenerated',
        :'customer' => :'customer',
        :'include_if_expression' => :'includeIfExpression',
        :'group_name' => :'groupName',
        :'recipient_type' => :'recipientType',
        :'company_email' => :'companyEmail',
        :'recipient' => :'recipient',
        :'recipient_address_type' => :'recipientAddressType',
        :'report' => :'report'
      }
    end
  end
end
