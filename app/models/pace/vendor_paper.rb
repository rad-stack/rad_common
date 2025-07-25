module Pace
  class VendorPaper < Base
    attr_accessor :size

    attr_accessor :color

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :primary_key

    attr_accessor :category

    attr_accessor :vendor

    attr_accessor :buy_size_width

    attr_accessor :buy_size_width_display_uom

    attr_accessor :paper_finish

    attr_accessor :paper_type

    attr_accessor :mweight

    attr_accessor :manufacturer

    attr_accessor :thickness

    attr_accessor :buy_size_length

    attr_accessor :thickness_uom

    attr_accessor :brand

    attr_accessor :buy_size_length_display_uom

    attr_accessor :carton_qty

    attr_accessor :item_number

    attr_accessor :cube

    attr_accessor :base_uom

    attr_accessor :core

    attr_accessor :grade

    attr_accessor :weight_uom

    attr_accessor :mfg_sku

    attr_accessor :env_number

    attr_accessor :basis_weight

    attr_accessor :price_uom

    attr_accessor :diameter

    attr_accessor :msrp

    attr_accessor :cube_uom

    attr_accessor :finish


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'size' => :'size',
        :'color' => :'color',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'primary_key' => :'primaryKey',
        :'category' => :'category',
        :'vendor' => :'vendor',
        :'buy_size_width' => :'buySizeWidth',
        :'buy_size_width_display_uom' => :'buySizeWidthDisplayUOM',
        :'paper_finish' => :'paperFinish',
        :'paper_type' => :'paperType',
        :'mweight' => :'mweight',
        :'manufacturer' => :'manufacturer',
        :'thickness' => :'thickness',
        :'buy_size_length' => :'buySizeLength',
        :'thickness_uom' => :'thicknessUOM',
        :'brand' => :'brand',
        :'buy_size_length_display_uom' => :'buySizeLengthDisplayUOM',
        :'carton_qty' => :'cartonQty',
        :'item_number' => :'itemNumber',
        :'cube' => :'cube',
        :'base_uom' => :'baseUom',
        :'core' => :'core',
        :'grade' => :'grade',
        :'weight_uom' => :'weightUom',
        :'mfg_sku' => :'mfgSku',
        :'env_number' => :'envNumber',
        :'basis_weight' => :'basisWeight',
        :'price_uom' => :'priceUom',
        :'diameter' => :'diameter',
        :'msrp' => :'msrp',
        :'cube_uom' => :'cubeUom',
        :'finish' => :'finish'
      }
    end
  end
end
