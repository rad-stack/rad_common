module Pace
  class QuoteProduct < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :manufacturing_location

    attr_accessor :inventory_item

    attr_accessor :quote

    attr_accessor :num_up

    attr_accessor :material_vendor

    attr_accessor :colors_s2

    attr_accessor :colors_s1

    attr_accessor :colors_total

    attr_accessor :ink_type

    attr_accessor :quote_item_type

    attr_accessor :quantity_multiplier

    attr_accessor :run_size_width

    attr_accessor :run_size_width_display_uom

    attr_accessor :resolution

    attr_accessor :sides

    attr_accessor :next_sequence

    attr_accessor :final_size_width

    attr_accessor :final_size_width_display_uom

    attr_accessor :final_size_length_display_uom

    attr_accessor :duplicate_sequence

    attr_accessor :sheets

    attr_accessor :product_type

    attr_accessor :final_size_length

    attr_accessor :run_size_length_display_uom

    attr_accessor :product_item

    attr_accessor :run_size_length

    attr_accessor :is_template


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'manufacturing_location' => :'manufacturingLocation',
        :'inventory_item' => :'inventoryItem',
        :'quote' => :'quote',
        :'num_up' => :'numUp',
        :'material_vendor' => :'materialVendor',
        :'colors_s2' => :'colorsS2',
        :'colors_s1' => :'colorsS1',
        :'colors_total' => :'colorsTotal',
        :'ink_type' => :'inkType',
        :'quote_item_type' => :'quoteItemType',
        :'quantity_multiplier' => :'quantityMultiplier',
        :'run_size_width' => :'runSizeWidth',
        :'run_size_width_display_uom' => :'runSizeWidthDisplayUOM',
        :'resolution' => :'resolution',
        :'sides' => :'sides',
        :'next_sequence' => :'nextSequence',
        :'final_size_width' => :'finalSizeWidth',
        :'final_size_width_display_uom' => :'finalSizeWidthDisplayUOM',
        :'final_size_length_display_uom' => :'finalSizeLengthDisplayUOM',
        :'duplicate_sequence' => :'duplicateSequence',
        :'sheets' => :'sheets',
        :'product_type' => :'productType',
        :'final_size_length' => :'finalSizeLength',
        :'run_size_length_display_uom' => :'runSizeLengthDisplayUOM',
        :'product_item' => :'productItem',
        :'run_size_length' => :'runSizeLength',
        :'is_template' => :'isTemplate'
      }
    end
  end
end
