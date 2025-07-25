module Pace
  class ManufacturingLocation < Base
    attr_accessor :id

    attr_accessor :state

    attr_accessor :active

    attr_accessor :country

    attr_accessor :description

    attr_accessor :prefix

    attr_accessor :tags

    attr_accessor :code

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :state_key

    attr_accessor :phone_number

    attr_accessor :default_contact

    attr_accessor :zip

    attr_accessor :city

    attr_accessor :address3

    attr_accessor :address2

    attr_accessor :address1

    attr_accessor :plant_id

    attr_accessor :offset_activity_code

    attr_accessor :default_customer

    attr_accessor :default_job_description

    attr_accessor :default_job_type

    attr_accessor :default_job_type_print_part

    attr_accessor :default_press

    attr_accessor :vertex_origin_tax_area_id

    attr_accessor :default_item_template

    attr_accessor :default_wide_format_press

    attr_accessor :default_job_type_fin_goods_part

    attr_accessor :default_job_status

    attr_accessor :maximum_logged_in_users

    attr_accessor :tax_reference1

    attr_accessor :tax_reference2

    attr_accessor :ucc_prefix

    attr_accessor :default_job_product_description

    attr_accessor :fiery_routing_destination

    attr_accessor :default_job_part_description

    attr_accessor :site_license_type

    attr_accessor :scheduler_instance

    attr_accessor :parent_manufacturing_location

    attr_accessor :bill_of_lading_number_prefix

    attr_accessor :address_name

    attr_accessor :bill_of_lading_number_seq

    attr_accessor :default_job_additional_description_note


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'state' => :'state',
        :'active' => :'active',
        :'country' => :'country',
        :'description' => :'description',
        :'prefix' => :'prefix',
        :'tags' => :'tags',
        :'code' => :'code',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'state_key' => :'stateKey',
        :'phone_number' => :'phoneNumber',
        :'default_contact' => :'defaultContact',
        :'zip' => :'zip',
        :'city' => :'city',
        :'address3' => :'address3',
        :'address2' => :'address2',
        :'address1' => :'address1',
        :'plant_id' => :'plantId',
        :'offset_activity_code' => :'offsetActivityCode',
        :'default_customer' => :'defaultCustomer',
        :'default_job_description' => :'defaultJobDescription',
        :'default_job_type' => :'defaultJobType',
        :'default_job_type_print_part' => :'defaultJobTypePrintPart',
        :'default_press' => :'defaultPress',
        :'vertex_origin_tax_area_id' => :'vertexOriginTaxAreaID',
        :'default_item_template' => :'defaultItemTemplate',
        :'default_wide_format_press' => :'defaultWideFormatPress',
        :'default_job_type_fin_goods_part' => :'defaultJobTypeFinGoodsPart',
        :'default_job_status' => :'defaultJobStatus',
        :'maximum_logged_in_users' => :'maximumLoggedInUsers',
        :'tax_reference1' => :'taxReference1',
        :'tax_reference2' => :'taxReference2',
        :'ucc_prefix' => :'uccPrefix',
        :'default_job_product_description' => :'defaultJobProductDescription',
        :'fiery_routing_destination' => :'fieryRoutingDestination',
        :'default_job_part_description' => :'defaultJobPartDescription',
        :'site_license_type' => :'siteLicenseType',
        :'scheduler_instance' => :'schedulerInstance',
        :'parent_manufacturing_location' => :'parentManufacturingLocation',
        :'bill_of_lading_number_prefix' => :'billOfLadingNumberPrefix',
        :'address_name' => :'addressName',
        :'bill_of_lading_number_seq' => :'billOfLadingNumberSeq',
        :'default_job_additional_description_note' => :'defaultJobAdditionalDescriptionNote'
      }
    end
  end
end
