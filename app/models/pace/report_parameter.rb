module Pace
  class ReportParameter < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :description

    attr_accessor :expression

    attr_accessor :list

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :data_object

    attr_accessor :system_generated

    attr_accessor :sequence

    attr_accessor :data_type

    attr_accessor :expression_type

    attr_accessor :report

    attr_accessor :expression_type_forced

    attr_accessor :prompt_forced

    attr_accessor :prompt

    attr_accessor :expression_forced

    attr_accessor :name_forced

    attr_accessor :description_forced

    attr_accessor :data_type_forced

    attr_accessor :accept_multi_select_forced

    attr_accessor :accept_multi_value

    attr_accessor :logo

    attr_accessor :sequence_forced

    attr_accessor :accept_multi_select

    attr_accessor :accept_multi_value_forced

    attr_accessor :logo_forced


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'description' => :'description',
        :'expression' => :'expression',
        :'list' => :'list',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'data_object' => :'dataObject',
        :'system_generated' => :'systemGenerated',
        :'sequence' => :'sequence',
        :'data_type' => :'dataType',
        :'expression_type' => :'expressionType',
        :'report' => :'report',
        :'expression_type_forced' => :'expressionTypeForced',
        :'prompt_forced' => :'promptForced',
        :'prompt' => :'prompt',
        :'expression_forced' => :'expressionForced',
        :'name_forced' => :'nameForced',
        :'description_forced' => :'descriptionForced',
        :'data_type_forced' => :'dataTypeForced',
        :'accept_multi_select_forced' => :'acceptMultiSelectForced',
        :'accept_multi_value' => :'acceptMultiValue',
        :'logo' => :'logo',
        :'sequence_forced' => :'sequenceForced',
        :'accept_multi_select' => :'acceptMultiSelect',
        :'accept_multi_value_forced' => :'acceptMultiValueForced',
        :'logo_forced' => :'logoForced'
      }
    end
  end
end
