module Pace
  class ComboJob < Base
    attr_accessor :percent

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :primary_key

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :job_job_part_key

    attr_accessor :percent_forced

    attr_accessor :combo_job


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'percent' => :'percent',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'primary_key' => :'primaryKey',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'job_job_part_key' => :'jobJobPartKey',
        :'percent_forced' => :'percentForced',
        :'combo_job' => :'comboJob'
      }
    end
  end
end
