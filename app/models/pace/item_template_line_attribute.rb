module Pace
  class ItemTemplateLineAttribute < Base
    attr_accessor :id

    attr_accessor :default_value

    attr_accessor :attribute

    attr_accessor :attribute_type

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :quantity

    attr_accessor :expression_type

    attr_accessor :expression_type_forced

    attr_accessor :item_template_line


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'default_value' => :'defaultValue',
        :'attribute' => :'attribute',
        :'attribute_type' => :'attributeType',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'quantity' => :'quantity',
        :'expression_type' => :'expressionType',
        :'expression_type_forced' => :'expressionTypeForced',
        :'item_template_line' => :'itemTemplateLine'
      }
    end
  end
end
