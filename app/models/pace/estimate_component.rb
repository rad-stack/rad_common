module Pace
  class EstimateComponent < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :versions

    attr_accessor :qty_to_mfg

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :estimate_part

    attr_accessor :final_size_w

    attr_accessor :colors_s2

    attr_accessor :colors_s1

    attr_accessor :final_size_w_display_uom

    attr_accessor :final_size_h

    attr_accessor :num_sigs

    attr_accessor :final_size_h_display_uom

    attr_accessor :colors_total

    attr_accessor :qty_ordered


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'versions' => :'versions',
        :'qty_to_mfg' => :'qtyToMfg',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'estimate_part' => :'estimatePart',
        :'final_size_w' => :'finalSizeW',
        :'colors_s2' => :'colorsS2',
        :'colors_s1' => :'colorsS1',
        :'final_size_w_display_uom' => :'finalSizeWDisplayUOM',
        :'final_size_h' => :'finalSizeH',
        :'num_sigs' => :'numSigs',
        :'final_size_h_display_uom' => :'finalSizeHDisplayUOM',
        :'colors_total' => :'colorsTotal',
        :'qty_ordered' => :'qtyOrdered'
      }
    end
  end
end
