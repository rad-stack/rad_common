module Pace
  class JobPartOption < Base
    attr_accessor :id

    attr_accessor :option

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :quantity_per_unit

    attr_accessor :job_part_key

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :finishing_operation

    attr_accessor :vendor

    attr_accessor :job_material

    attr_accessor :finishing_operation_material

    attr_accessor :option_note


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'option' => :'option',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'quantity_per_unit' => :'quantityPerUnit',
        :'job_part_key' => :'jobPartKey',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'finishing_operation' => :'finishingOperation',
        :'vendor' => :'vendor',
        :'job_material' => :'jobMaterial',
        :'finishing_operation_material' => :'finishingOperationMaterial',
        :'option_note' => :'optionNote'
      }
    end
  end
end
