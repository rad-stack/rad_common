module Pace
  class PaceConnectExpressionMap < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :expression

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :max_length

    attr_accessor :sequence

    attr_accessor :data_type

    attr_accessor :pace_connect_generated

    attr_accessor :external_system_attribute

    attr_accessor :pace_connect

    attr_accessor :pace_connect_generated_id

    attr_accessor :expression_type

    attr_accessor :row

    attr_accessor :base_object

    attr_accessor :pace_connect_file


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'expression' => :'expression',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'max_length' => :'maxLength',
        :'sequence' => :'sequence',
        :'data_type' => :'dataType',
        :'pace_connect_generated' => :'paceConnectGenerated',
        :'external_system_attribute' => :'externalSystemAttribute',
        :'pace_connect' => :'paceConnect',
        :'pace_connect_generated_id' => :'paceConnectGeneratedID',
        :'expression_type' => :'expressionType',
        :'row' => :'row',
        :'base_object' => :'baseObject',
        :'pace_connect_file' => :'paceConnectFile'
      }
    end
  end
end
