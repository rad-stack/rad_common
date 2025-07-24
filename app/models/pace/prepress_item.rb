module Pace
  class PrepressItem < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :code

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :unit_label

    attr_accessor :sequence

    attr_accessor :note

    attr_accessor :customer_viewable

    attr_accessor :alt_description

    attr_accessor :jdf_device_id

    attr_accessor :activity_code_labor

    attr_accessor :jdf_default_item

    attr_accessor :activity_code_materials

    attr_accessor :prepress_type

    attr_accessor :num_strip_pieces

    attr_accessor :jdf_prepress_type

    attr_accessor :min_colors

    attr_accessor :max_colors

    attr_accessor :num_flats

    attr_accessor :use_sizes

    attr_accessor :prepress_group


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'code' => :'code',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'unit_label' => :'unitLabel',
        :'sequence' => :'sequence',
        :'note' => :'note',
        :'customer_viewable' => :'customerViewable',
        :'alt_description' => :'altDescription',
        :'jdf_device_id' => :'jdfDeviceID',
        :'activity_code_labor' => :'activityCodeLabor',
        :'jdf_default_item' => :'jdfDefaultItem',
        :'activity_code_materials' => :'activityCodeMaterials',
        :'prepress_type' => :'prepressType',
        :'num_strip_pieces' => :'numStripPieces',
        :'jdf_prepress_type' => :'jdfPrepressType',
        :'min_colors' => :'minColors',
        :'max_colors' => :'maxColors',
        :'num_flats' => :'numFlats',
        :'use_sizes' => :'useSizes',
        :'prepress_group' => :'prepressGroup'
      }
    end
  end
end
