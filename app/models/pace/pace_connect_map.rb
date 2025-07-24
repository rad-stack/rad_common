module Pace
  class PaceConnectMap < Base
    attr_accessor :value

    attr_accessor :key

    attr_accessor :id

    attr_accessor :state

    attr_accessor :type

    attr_accessor :active

    attr_accessor :country

    attr_accessor :description

    attr_accessor :integer_value

    attr_accessor :contact

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_generated

    attr_accessor :sequence

    attr_accessor :height_display_uom

    attr_accessor :width

    attr_accessor :width_display_uom

    attr_accessor :height

    attr_accessor :state_key

    attr_accessor :price_list

    attr_accessor :ship_via

    attr_accessor :terms

    attr_accessor :manufacturing_location

    attr_accessor :customer_status

    attr_accessor :finishing_operation

    attr_accessor :pace_connect

    attr_accessor :customer

    attr_accessor :inventory_item

    attr_accessor :uom

    attr_accessor :note_category

    attr_accessor :press

    attr_accessor :non_planned_reason

    attr_accessor :activity_code

    attr_accessor :prepress_workflow

    attr_accessor :job_product_type

    attr_accessor :finishing_option

    attr_accessor :paper_type

    attr_accessor :vendor_type

    attr_accessor :quote_category

    attr_accessor :job_status

    attr_accessor :forced

    attr_accessor :jdf_dimension

    attr_accessor :string_value

    attr_accessor :status_priority

    attr_accessor :mta_job_note_xpath

    attr_accessor :jdf_weight

    attr_accessor :jdf_custom_media_type

    attr_accessor :jdf_descriptive_name

    attr_accessor :note_department

    attr_accessor :enable_status_change

    attr_accessor :jdf_thickness

    attr_accessor :map_type

    attr_accessor :material


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'value' => :'value',
        :'key' => :'key',
        :'id' => :'id',
        :'state' => :'state',
        :'type' => :'type',
        :'active' => :'active',
        :'country' => :'country',
        :'description' => :'description',
        :'integer_value' => :'integerValue',
        :'contact' => :'contact',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'system_generated' => :'systemGenerated',
        :'sequence' => :'sequence',
        :'height_display_uom' => :'heightDisplayUOM',
        :'width' => :'width',
        :'width_display_uom' => :'widthDisplayUOM',
        :'height' => :'height',
        :'state_key' => :'stateKey',
        :'price_list' => :'priceList',
        :'ship_via' => :'shipVia',
        :'terms' => :'terms',
        :'manufacturing_location' => :'manufacturingLocation',
        :'customer_status' => :'customerStatus',
        :'finishing_operation' => :'finishingOperation',
        :'pace_connect' => :'paceConnect',
        :'customer' => :'customer',
        :'inventory_item' => :'inventoryItem',
        :'uom' => :'uom',
        :'note_category' => :'noteCategory',
        :'press' => :'press',
        :'non_planned_reason' => :'nonPlannedReason',
        :'activity_code' => :'activityCode',
        :'prepress_workflow' => :'prepressWorkflow',
        :'job_product_type' => :'jobProductType',
        :'finishing_option' => :'finishingOption',
        :'paper_type' => :'paperType',
        :'vendor_type' => :'vendorType',
        :'quote_category' => :'quoteCategory',
        :'job_status' => :'jobStatus',
        :'forced' => :'forced',
        :'jdf_dimension' => :'jdfDimension',
        :'string_value' => :'stringValue',
        :'status_priority' => :'statusPriority',
        :'mta_job_note_xpath' => :'mtaJobNoteXpath',
        :'jdf_weight' => :'jdfWeight',
        :'jdf_custom_media_type' => :'jdfCustomMediaType',
        :'jdf_descriptive_name' => :'jdfDescriptiveName',
        :'note_department' => :'noteDepartment',
        :'enable_status_change' => :'enableStatusChange',
        :'jdf_thickness' => :'jdfThickness',
        :'map_type' => :'mapType',
        :'material' => :'material'
      }
    end
  end
end
