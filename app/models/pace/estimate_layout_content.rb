module Pace
  class EstimateLayoutContent < Base
    attr_accessor :signature

    attr_accessor :locked

    attr_accessor :color

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :quantity

    attr_accessor :press

    attr_accessor :total_quantity

    attr_accessor :num_up

    attr_accessor :percent_usage

    attr_accessor :component_instance

    attr_accessor :content_estimate_part

    attr_accessor :required_cuts

    attr_accessor :quantity_difference

    attr_accessor :estimate_layout_content_id

    attr_accessor :estimate_layout

    attr_accessor :length_to_cut


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'signature' => :'signature',
        :'locked' => :'locked',
        :'color' => :'color',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'quantity' => :'quantity',
        :'press' => :'press',
        :'total_quantity' => :'totalQuantity',
        :'num_up' => :'numUp',
        :'percent_usage' => :'percentUsage',
        :'component_instance' => :'componentInstance',
        :'content_estimate_part' => :'contentEstimatePart',
        :'required_cuts' => :'requiredCuts',
        :'quantity_difference' => :'quantityDifference',
        :'estimate_layout_content_id' => :'estimateLayoutContentId',
        :'estimate_layout' => :'estimateLayout',
        :'length_to_cut' => :'lengthToCut'
      }
    end
  end
end
