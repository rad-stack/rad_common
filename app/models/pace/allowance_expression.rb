module Pace
  class AllowanceExpression < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :label

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :estimate_allowance_expression

    attr_accessor :job_part_allowance_expression


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'label' => :'label',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'estimate_allowance_expression' => :'estimateAllowanceExpression',
        :'job_part_allowance_expression' => :'jobPartAllowanceExpression'
      }
    end
  end
end
