module Pace
  class EstimatePrepressOp < Base
    attr_accessor :id

    attr_accessor :state

    attr_accessor :hours

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :unit_label

    attr_accessor :sequence

    attr_accessor :item_template

    attr_accessor :quantity

    attr_accessor :material_cost

    attr_accessor :add_cost

    attr_accessor :customer_viewable

    attr_accessor :quantity_forced

    attr_accessor :size_height_display_uom

    attr_accessor :size_width_display_uom

    attr_accessor :size_height

    attr_accessor :correlation_id

    attr_accessor :material_cost_forced

    attr_accessor :size_width

    attr_accessor :num_out

    attr_accessor :unit_label_forced

    attr_accessor :hours_forced

    attr_accessor :prepress_item

    attr_accessor :forced_size

    attr_accessor :estimate_quantity

    attr_accessor :prep_activity

    attr_accessor :add_hours

    attr_accessor :ganged


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'state' => :'state',
        :'hours' => :'hours',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'unit_label' => :'unitLabel',
        :'sequence' => :'sequence',
        :'item_template' => :'itemTemplate',
        :'quantity' => :'quantity',
        :'material_cost' => :'materialCost',
        :'add_cost' => :'addCost',
        :'customer_viewable' => :'customerViewable',
        :'quantity_forced' => :'quantityForced',
        :'size_height_display_uom' => :'sizeHeightDisplayUOM',
        :'size_width_display_uom' => :'sizeWidthDisplayUOM',
        :'size_height' => :'sizeHeight',
        :'correlation_id' => :'correlationId',
        :'material_cost_forced' => :'materialCostForced',
        :'size_width' => :'sizeWidth',
        :'num_out' => :'numOut',
        :'unit_label_forced' => :'unitLabelForced',
        :'hours_forced' => :'hoursForced',
        :'prepress_item' => :'prepressItem',
        :'forced_size' => :'forcedSize',
        :'estimate_quantity' => :'estimateQuantity',
        :'prep_activity' => :'prepActivity',
        :'add_hours' => :'addHours',
        :'ganged' => :'ganged'
      }
    end
  end
end
