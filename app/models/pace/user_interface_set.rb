module Pace
  class UserInterfaceSet < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_generated

    attr_accessor :production_type

    attr_accessor :estimate_finishing_op_shipping_add

    attr_accessor :job_detail

    attr_accessor :job_part_add

    attr_accessor :estimate_request_detail

    attr_accessor :job_add

    attr_accessor :estimate_detail

    attr_accessor :estimate_press_add

    attr_accessor :estimate_request_add

    attr_accessor :estimate_prepress_op_add

    attr_accessor :estimate_part_add

    attr_accessor :estimate_finishing_op_detail

    attr_accessor :estimate_part_add_blank

    attr_accessor :estimate_finishing_op_add

    attr_accessor :job_material_add

    attr_accessor :estimate_product_detail

    attr_accessor :job_part_press_form_add

    attr_accessor :estimate_press_detail

    attr_accessor :estimate_request_product_detail

    attr_accessor :job_part_press_form_direct_add

    attr_accessor :estimate_composite_product_detail

    attr_accessor :job_product_detail

    attr_accessor :job_part_finishing_op_add

    attr_accessor :estimate_finishing_op_shipping_detail

    attr_accessor :job_part_press_form_detail

    attr_accessor :estimate_product_detail_popup

    attr_accessor :job_material_detail

    attr_accessor :estimate_request_product_add_vehicle

    attr_accessor :estimate_composite_product_add

    attr_accessor :estimate_paper_add

    attr_accessor :estimate_paper_detail

    attr_accessor :job_part_finishing_op_detail

    attr_accessor :estimate_request_product_vehicle_detail

    attr_accessor :job_part_detail

    attr_accessor :job_product_detail_popup

    attr_accessor :job_part_press_form_direct_detail

    attr_accessor :estimate_product_add_dynamic

    attr_accessor :estimate_add

    attr_accessor :estimate_request_product_job_product_type_add

    attr_accessor :estimate_prepress_op_detail

    attr_accessor :estimate_quantity_detail

    attr_accessor :estimate_ink_detail

    attr_accessor :estimate_request_product_composite_product_add


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'system_generated' => :'systemGenerated',
        :'production_type' => :'productionType',
        :'estimate_finishing_op_shipping_add' => :'estimateFinishingOpShippingAdd',
        :'job_detail' => :'jobDetail',
        :'job_part_add' => :'jobPartAdd',
        :'estimate_request_detail' => :'estimateRequestDetail',
        :'job_add' => :'jobAdd',
        :'estimate_detail' => :'estimateDetail',
        :'estimate_press_add' => :'estimatePressAdd',
        :'estimate_request_add' => :'estimateRequestAdd',
        :'estimate_prepress_op_add' => :'estimatePrepressOpAdd',
        :'estimate_part_add' => :'estimatePartAdd',
        :'estimate_finishing_op_detail' => :'estimateFinishingOpDetail',
        :'estimate_part_add_blank' => :'estimatePartAddBlank',
        :'estimate_finishing_op_add' => :'estimateFinishingOpAdd',
        :'job_material_add' => :'jobMaterialAdd',
        :'estimate_product_detail' => :'estimateProductDetail',
        :'job_part_press_form_add' => :'jobPartPressFormAdd',
        :'estimate_press_detail' => :'estimatePressDetail',
        :'estimate_request_product_detail' => :'estimateRequestProductDetail',
        :'job_part_press_form_direct_add' => :'jobPartPressFormDirectAdd',
        :'estimate_composite_product_detail' => :'estimateCompositeProductDetail',
        :'job_product_detail' => :'jobProductDetail',
        :'job_part_finishing_op_add' => :'jobPartFinishingOpAdd',
        :'estimate_finishing_op_shipping_detail' => :'estimateFinishingOpShippingDetail',
        :'job_part_press_form_detail' => :'jobPartPressFormDetail',
        :'estimate_product_detail_popup' => :'estimateProductDetailPopup',
        :'job_material_detail' => :'jobMaterialDetail',
        :'estimate_request_product_add_vehicle' => :'estimateRequestProductAddVehicle',
        :'estimate_composite_product_add' => :'estimateCompositeProductAdd',
        :'estimate_paper_add' => :'estimatePaperAdd',
        :'estimate_paper_detail' => :'estimatePaperDetail',
        :'job_part_finishing_op_detail' => :'jobPartFinishingOpDetail',
        :'estimate_request_product_vehicle_detail' => :'estimateRequestProductVehicleDetail',
        :'job_part_detail' => :'jobPartDetail',
        :'job_product_detail_popup' => :'jobProductDetailPopup',
        :'job_part_press_form_direct_detail' => :'jobPartPressFormDirectDetail',
        :'estimate_product_add_dynamic' => :'estimateProductAddDynamic',
        :'estimate_add' => :'estimateAdd',
        :'estimate_request_product_job_product_type_add' => :'estimateRequestProductJobProductTypeAdd',
        :'estimate_prepress_op_detail' => :'estimatePrepressOpDetail',
        :'estimate_quantity_detail' => :'estimateQuantityDetail',
        :'estimate_ink_detail' => :'estimateInkDetail',
        :'estimate_request_product_composite_product_add' => :'estimateRequestProductCompositeProductAdd'
      }
    end
  end
end
