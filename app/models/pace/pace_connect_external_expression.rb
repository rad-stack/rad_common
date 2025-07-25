module Pace
  class PaceConnectExternalExpression < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :xpath_expression

    attr_accessor :pace_connect_generated

    attr_accessor :pace_connect

    attr_accessor :pace_connect_generated_id

    attr_accessor :department

    attr_accessor :sub_note_category

    attr_accessor :external_expression_type

    attr_accessor :pace_object

    attr_accessor :pace_attribute


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'xpath_expression' => :'xpathExpression',
        :'pace_connect_generated' => :'paceConnectGenerated',
        :'pace_connect' => :'paceConnect',
        :'pace_connect_generated_id' => :'paceConnectGeneratedID',
        :'department' => :'department',
        :'sub_note_category' => :'subNoteCategory',
        :'external_expression_type' => :'externalExpressionType',
        :'pace_object' => :'paceObject',
        :'pace_attribute' => :'paceAttribute'
      }
    end
  end
end
