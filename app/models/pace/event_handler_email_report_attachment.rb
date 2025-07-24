module Pace
  class EventHandlerEmailReportAttachment < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_generated

    attr_accessor :report_package

    attr_accessor :report

    attr_accessor :consequence

    attr_accessor :report_object_expression

    attr_accessor :event


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'system_generated' => :'systemGenerated',
        :'report_package' => :'reportPackage',
        :'report' => :'report',
        :'consequence' => :'consequence',
        :'report_object_expression' => :'reportObjectExpression',
        :'event' => :'event'
      }
    end
  end
end
