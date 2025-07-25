module Pace
  class JobPartContentFile < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :content_file_category

    attr_accessor :production

    attr_accessor :origin

    attr_accessor :estimate_source

    attr_accessor :content_file

    attr_accessor :job_part_press_form

    attr_accessor :metrix_cutter_operations

    attr_accessor :job_part

    attr_accessor :proof

    attr_accessor :job

    attr_accessor :sequence


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'content_file_category' => :'contentFileCategory',
        :'production' => :'production',
        :'origin' => :'origin',
        :'estimate_source' => :'estimateSource',
        :'content_file' => :'contentFile',
        :'job_part_press_form' => :'jobPartPressForm',
        :'metrix_cutter_operations' => :'metrixCutterOperations',
        :'job_part' => :'jobPart',
        :'proof' => :'proof',
        :'job' => :'job',
        :'sequence' => :'sequence'
      }
    end
  end
end
