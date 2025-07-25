module Pace
  class ReportCondition < Base
    attr_accessor :message

    attr_accessor :id

    attr_accessor :expression

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :report

    attr_accessor :consequence

    attr_accessor :condition_type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'message' => :'message',
        :'id' => :'id',
        :'expression' => :'expression',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'report' => :'report',
        :'consequence' => :'consequence',
        :'condition_type' => :'conditionType'
      }
    end
  end
end
