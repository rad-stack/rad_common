module Pace
  class EstimateLayout < Base
    attr_accessor :position

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :estimate

    attr_accessor :display_graphics

    attr_accessor :sheets_required

    attr_accessor :estimate_layout_id

    attr_accessor :sheet_area_usage


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'position' => :'position',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'estimate' => :'estimate',
        :'display_graphics' => :'displayGraphics',
        :'sheets_required' => :'sheetsRequired',
        :'estimate_layout_id' => :'estimateLayoutId',
        :'sheet_area_usage' => :'sheetAreaUsage'
      }
    end
  end
end
