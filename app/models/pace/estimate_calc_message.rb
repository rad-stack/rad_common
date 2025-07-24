module Pace
  class EstimateCalcMessage < Base
    attr_accessor :message

    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :estimate_part

    attr_accessor :estimate_quantity


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'message' => :'message',
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'category' => :'category',
        :'estimate_part' => :'estimatePart',
        :'estimate_quantity' => :'estimateQuantity'
      }
    end
  end
end
