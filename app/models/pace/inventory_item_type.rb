module Pace
  class InventoryItemType < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :packaging

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :paper

    attr_accessor :ink

    attr_accessor :finished_goods

    attr_accessor :plant_manager_item

    attr_accessor :gl_cogs_account

    attr_accessor :gl_asset_account

    attr_accessor :mdff_catalog_item

    attr_accessor :kit

    attr_accessor :variable_size

    attr_accessor :verify_negative_quantity

    attr_accessor :track_lots_and_revisions

    attr_accessor :imageable_side

    attr_accessor :print_stream_catalog_item

    attr_accessor :use_serial_id

    attr_accessor :gl_inventory_variance_account

    attr_accessor :default_convert_job_type

    attr_accessor :allow_decimal_units

    attr_accessor :dsf_catalog_item

    attr_accessor :posting_method


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'packaging' => :'packaging',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'paper' => :'paper',
        :'ink' => :'ink',
        :'finished_goods' => :'finishedGoods',
        :'plant_manager_item' => :'plantManagerItem',
        :'gl_cogs_account' => :'glCogsAccount',
        :'gl_asset_account' => :'glAssetAccount',
        :'mdff_catalog_item' => :'mdffCatalogItem',
        :'kit' => :'kit',
        :'variable_size' => :'variableSize',
        :'verify_negative_quantity' => :'verifyNegativeQuantity',
        :'track_lots_and_revisions' => :'trackLotsAndRevisions',
        :'imageable_side' => :'imageableSide',
        :'print_stream_catalog_item' => :'printStreamCatalogItem',
        :'use_serial_id' => :'useSerialID',
        :'gl_inventory_variance_account' => :'glInventoryVarianceAccount',
        :'default_convert_job_type' => :'defaultConvertJobType',
        :'allow_decimal_units' => :'allowDecimalUnits',
        :'dsf_catalog_item' => :'dsfCatalogItem',
        :'posting_method' => :'postingMethod'
      }
    end
  end
end
