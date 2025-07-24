module Pace
  class Expression < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :expression

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :expression_type

    attr_accessor :base_object

    attr_accessor :expression_category


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'expression' => :'expression',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'expression_type' => :'expressionType',
        :'base_object' => :'baseObject',
        :'expression_category' => :'expressionCategory'
      }
    end
  end
end
