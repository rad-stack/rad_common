module Pace
  class ItemTemplateLine < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :data_object

    attr_accessor :sequence

    attr_accessor :item_template

    attr_accessor :quantity_expression

    attr_accessor :required_fields

    attr_accessor :parent_line

    attr_accessor :exclude_expression

    attr_accessor :related_line

    attr_accessor :selected_fields

    attr_accessor :user_defined_parent


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'data_object' => :'dataObject',
        :'sequence' => :'sequence',
        :'item_template' => :'itemTemplate',
        :'quantity_expression' => :'quantityExpression',
        :'required_fields' => :'requiredFields',
        :'parent_line' => :'parentLine',
        :'exclude_expression' => :'excludeExpression',
        :'related_line' => :'relatedLine',
        :'selected_fields' => :'selectedFields',
        :'user_defined_parent' => :'userDefinedParent'
      }
    end
  end
end
