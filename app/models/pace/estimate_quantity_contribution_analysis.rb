module Pace
  class EstimateQuantityContributionAnalysis < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :sequence

    attr_accessor :estimate_quantity

    attr_accessor :contribution

    attr_accessor :percentage

    attr_accessor :category_breakdown


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'category' => :'category',
        :'sequence' => :'sequence',
        :'estimate_quantity' => :'estimateQuantity',
        :'contribution' => :'contribution',
        :'percentage' => :'percentage',
        :'category_breakdown' => :'categoryBreakdown'
      }
    end
  end
end
