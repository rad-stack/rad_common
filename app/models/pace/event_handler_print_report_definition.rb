module Pace
  class EventHandlerPrintReportDefinition < Base
    attr_accessor :id

    attr_accessor :handler

    attr_accessor :expression

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_generated

    attr_accessor :report_package

    attr_accessor :report

    attr_accessor :printer_select


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'handler' => :'handler',
        :'expression' => :'expression',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'system_generated' => :'systemGenerated',
        :'report_package' => :'reportPackage',
        :'report' => :'report',
        :'printer_select' => :'printerSelect'
      }
    end
  end
end
