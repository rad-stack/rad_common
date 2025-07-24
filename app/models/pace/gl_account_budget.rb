module Pace
  class GLAccountBudget < Base
    attr_accessor :id

    attr_accessor :percent

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :amount

    attr_accessor :gl_accounting_period

    attr_accessor :gl_account

    attr_accessor :percent_department

    attr_accessor :percent_account

    attr_accessor :percent_location


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'percent' => :'percent',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'gl_department' => :'glDepartment',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'amount' => :'amount',
        :'gl_accounting_period' => :'glAccountingPeriod',
        :'gl_account' => :'glAccount',
        :'percent_department' => :'percentDepartment',
        :'percent_account' => :'percentAccount',
        :'percent_location' => :'percentLocation'
      }
    end
  end
end
