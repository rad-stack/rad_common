module Pace
  class GLAccountingPeriodSummaryName < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :gl_accounting_period

    attr_accessor :gl_summary_name


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'gl_accounting_period' => :'glAccountingPeriod',
        :'gl_summary_name' => :'glSummaryName'
      }
    end
  end
end
