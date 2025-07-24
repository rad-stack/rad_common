module Pace
  class OutsidePurchaseWorkflowItem < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :outside_purchase_workflow

    attr_accessor :outside_purchase_template


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'outside_purchase_workflow' => :'outsidePurchaseWorkflow',
        :'outside_purchase_template' => :'outsidePurchaseTemplate'
      }
    end
  end
end
