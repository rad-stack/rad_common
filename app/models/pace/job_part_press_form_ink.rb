module Pace
  class JobPartPressFormInk < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_press_form

    attr_accessor :inventory_item

    attr_accessor :job_material

    attr_accessor :ink_type

    attr_accessor :side

    attr_accessor :plate_id

    attr_accessor :job_plan_links_editable

    attr_accessor :new_plate

    attr_accessor :job_plan_links_enabled


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_press_form' => :'jobPartPressForm',
        :'inventory_item' => :'inventoryItem',
        :'job_material' => :'jobMaterial',
        :'ink_type' => :'inkType',
        :'side' => :'side',
        :'plate_id' => :'plateId',
        :'job_plan_links_editable' => :'jobPlanLinksEditable',
        :'new_plate' => :'newPlate',
        :'job_plan_links_enabled' => :'jobPlanLinksEnabled'
      }
    end
  end
end
