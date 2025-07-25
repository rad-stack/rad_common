module Pace
  class ReportPackageEntryParameter < Base
    attr_accessor :id

    attr_accessor :expression

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :expression_type

    attr_accessor :report_package_entry

    attr_accessor :expression_type_forced

    attr_accessor :prompt_forced

    attr_accessor :prompt

    attr_accessor :report_parameter

    attr_accessor :expression_forced


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'expression' => :'expression',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'expression_type' => :'expressionType',
        :'report_package_entry' => :'reportPackageEntry',
        :'expression_type_forced' => :'expressionTypeForced',
        :'prompt_forced' => :'promptForced',
        :'prompt' => :'prompt',
        :'report_parameter' => :'reportParameter',
        :'expression_forced' => :'expressionForced'
      }
    end
  end
end
