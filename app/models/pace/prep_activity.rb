module Pace
  class PrepActivity < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :estimate_expression

    attr_accessor :prepress_item

    attr_accessor :quantity_calc_method

    attr_accessor :prepress_workflow

    attr_accessor :gang_calc_method

    attr_accessor :size_calc_method


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'estimate_expression' => :'estimateExpression',
        :'prepress_item' => :'prepressItem',
        :'quantity_calc_method' => :'quantityCalcMethod',
        :'prepress_workflow' => :'prepressWorkflow',
        :'gang_calc_method' => :'gangCalcMethod',
        :'size_calc_method' => :'sizeCalcMethod'
      }
    end
  end
end
