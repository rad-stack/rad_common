module Pace
  class EstimatePressContent < Base
    attr_accessor :id

    attr_accessor :signature

    attr_accessor :color

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :estimate_press

    attr_accessor :total_quantity

    attr_accessor :num_up

    attr_accessor :finishing_make_ready_sheets

    attr_accessor :finishing_run_spoilage_sheets

    attr_accessor :percent_usage

    attr_accessor :component_instance

    attr_accessor :component_perimeter

    attr_accessor :content_estimate_part

    attr_accessor :sheets_required

    attr_accessor :required_cuts

    attr_accessor :quantity_difference


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'signature' => :'signature',
        :'color' => :'color',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'estimate_press' => :'estimatePress',
        :'total_quantity' => :'totalQuantity',
        :'num_up' => :'numUp',
        :'finishing_make_ready_sheets' => :'finishingMakeReadySheets',
        :'finishing_run_spoilage_sheets' => :'finishingRunSpoilageSheets',
        :'percent_usage' => :'percentUsage',
        :'component_instance' => :'componentInstance',
        :'component_perimeter' => :'componentPerimeter',
        :'content_estimate_part' => :'contentEstimatePart',
        :'sheets_required' => :'sheetsRequired',
        :'required_cuts' => :'requiredCuts',
        :'quantity_difference' => :'quantityDifference'
      }
    end
  end
end
