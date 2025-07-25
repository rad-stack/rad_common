module Pace
  class JobPartPressFormContent < Base
    attr_accessor :id

    attr_accessor :signature

    attr_accessor :locked

    attr_accessor :color

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_press_form

    attr_accessor :num_up

    attr_accessor :finishing_make_ready_sheets

    attr_accessor :finishing_run_spoilage_sheets

    attr_accessor :content_job

    attr_accessor :content_job_part

    attr_accessor :percent_usage

    attr_accessor :content_job_part_key

    attr_accessor :component_instance


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'signature' => :'signature',
        :'locked' => :'locked',
        :'color' => :'color',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_press_form' => :'jobPartPressForm',
        :'num_up' => :'numUp',
        :'finishing_make_ready_sheets' => :'finishingMakeReadySheets',
        :'finishing_run_spoilage_sheets' => :'finishingRunSpoilageSheets',
        :'content_job' => :'contentJob',
        :'content_job_part' => :'contentJobPart',
        :'percent_usage' => :'percentUsage',
        :'content_job_part_key' => :'contentJobPartKey',
        :'component_instance' => :'componentInstance'
      }
    end
  end
end
