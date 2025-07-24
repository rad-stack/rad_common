module Pace
  class PaceConnectMapConfigEntry < Base
    attr_accessor :key

    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :xpath_expression

    attr_accessor :job_part

    attr_accessor :department

    attr_accessor :sub_note_category

    attr_accessor :finishing_option

    attr_accessor :pace_connect_map_config


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'key' => :'key',
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'xpath_expression' => :'xpathExpression',
        :'job_part' => :'jobPart',
        :'department' => :'department',
        :'sub_note_category' => :'subNoteCategory',
        :'finishing_option' => :'finishingOption',
        :'pace_connect_map_config' => :'paceConnectMapConfig'
      }
    end
  end
end
