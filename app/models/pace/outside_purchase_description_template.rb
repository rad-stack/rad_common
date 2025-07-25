module Pace
  class OutsidePurchaseDescriptionTemplate < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :description_template_for_estimate

    attr_accessor :description_template_for_job

    attr_accessor :use_estimate_description_on_convert


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'description_template_for_estimate' => :'descriptionTemplateForEstimate',
        :'description_template_for_job' => :'descriptionTemplateForJob',
        :'use_estimate_description_on_convert' => :'useEstimateDescriptionOnConvert'
      }
    end
  end
end
