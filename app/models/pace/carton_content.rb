module Pace
  class CartonContent < Base
    attr_accessor :id

    attr_accessor :content

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :job_part_press_form

    attr_accessor :job_part

    attr_accessor :proof

    attr_accessor :job

    attr_accessor :sequence

    attr_accessor :quantity

    attr_accessor :note

    attr_accessor :original_planned_quantity

    attr_accessor :job_material

    attr_accessor :job_part_job

    attr_accessor :quantity_invoiced

    attr_accessor :job_product

    attr_accessor :carton

    attr_accessor :product_id

    attr_accessor :quantity_to_be_invoiced

    attr_accessor :content_quantity_ordered

    attr_accessor :billed_content

    attr_accessor :total_quantity

    attr_accessor :content_description

    attr_accessor :job_component

    attr_accessor :job_part_item


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'content' => :'content',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'job_part_press_form' => :'jobPartPressForm',
        :'job_part' => :'jobPart',
        :'proof' => :'proof',
        :'job' => :'job',
        :'sequence' => :'sequence',
        :'quantity' => :'quantity',
        :'note' => :'note',
        :'original_planned_quantity' => :'originalPlannedQuantity',
        :'job_material' => :'jobMaterial',
        :'job_part_job' => :'jobPartJob',
        :'quantity_invoiced' => :'quantityInvoiced',
        :'job_product' => :'jobProduct',
        :'carton' => :'carton',
        :'product_id' => :'productID',
        :'quantity_to_be_invoiced' => :'quantityToBeInvoiced',
        :'content_quantity_ordered' => :'contentQuantityOrdered',
        :'billed_content' => :'billedContent',
        :'total_quantity' => :'totalQuantity',
        :'content_description' => :'contentDescription',
        :'job_component' => :'jobComponent',
        :'job_part_item' => :'jobPartItem'
      }
    end
  end
end
