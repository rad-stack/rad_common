module Pace
  class AlternatePrintMethod < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :inventory_item

    attr_accessor :estimate_quantity

    attr_accessor :uom

    attr_accessor :press

    attr_accessor :num_across

    attr_accessor :num_up

    attr_accessor :num_stagger

    attr_accessor :num_along

    attr_accessor :estimated_cost

    attr_accessor :estimated_hours

    attr_accessor :run_size_height

    attr_accessor :grain_direction

    attr_accessor :panel_size_height_display_uom

    attr_accessor :panel_size_height

    attr_accessor :run_size_width

    attr_accessor :run_method

    attr_accessor :panel_size_width

    attr_accessor :run_size_width_display_uom

    attr_accessor :print_run_method

    attr_accessor :display_graphics

    attr_accessor :panel_size_width_display_uom

    attr_accessor :run_size_height_display_uom

    attr_accessor :buy_size_width

    attr_accessor :buy_size_height_display_uom

    attr_accessor :buy_size_width_display_uom

    attr_accessor :buy_size_height

    attr_accessor :run_size_grain_direction

    attr_accessor :mxml

    attr_accessor :planned_quantity

    attr_accessor :paper_price

    attr_accessor :primary_press

    attr_accessor :planned_quantity_uom

    attr_accessor :primary_alternate_print_method

    attr_accessor :has_odd_press

    attr_accessor :metrix_calculated

    attr_accessor :paper_efficiency

    attr_accessor :num_panels


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'inventory_item' => :'inventoryItem',
        :'estimate_quantity' => :'estimateQuantity',
        :'uom' => :'uom',
        :'press' => :'press',
        :'num_across' => :'numAcross',
        :'num_up' => :'numUp',
        :'num_stagger' => :'numStagger',
        :'num_along' => :'numAlong',
        :'estimated_cost' => :'estimatedCost',
        :'estimated_hours' => :'estimatedHours',
        :'run_size_height' => :'runSizeHeight',
        :'grain_direction' => :'grainDirection',
        :'panel_size_height_display_uom' => :'panelSizeHeightDisplayUOM',
        :'panel_size_height' => :'panelSizeHeight',
        :'run_size_width' => :'runSizeWidth',
        :'run_method' => :'runMethod',
        :'panel_size_width' => :'panelSizeWidth',
        :'run_size_width_display_uom' => :'runSizeWidthDisplayUOM',
        :'print_run_method' => :'printRunMethod',
        :'display_graphics' => :'displayGraphics',
        :'panel_size_width_display_uom' => :'panelSizeWidthDisplayUOM',
        :'run_size_height_display_uom' => :'runSizeHeightDisplayUOM',
        :'buy_size_width' => :'buySizeWidth',
        :'buy_size_height_display_uom' => :'buySizeHeightDisplayUOM',
        :'buy_size_width_display_uom' => :'buySizeWidthDisplayUOM',
        :'buy_size_height' => :'buySizeHeight',
        :'run_size_grain_direction' => :'runSizeGrainDirection',
        :'mxml' => :'mxml',
        :'planned_quantity' => :'plannedQuantity',
        :'paper_price' => :'paperPrice',
        :'primary_press' => :'primaryPress',
        :'planned_quantity_uom' => :'plannedQuantityUom',
        :'primary_alternate_print_method' => :'primaryAlternatePrintMethod',
        :'has_odd_press' => :'hasOddPress',
        :'metrix_calculated' => :'metrixCalculated',
        :'paper_efficiency' => :'paperEfficiency',
        :'num_panels' => :'numPanels'
      }
    end
  end
end
