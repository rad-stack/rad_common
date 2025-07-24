module Pace
  class AlternatePrintMethodContent < Base
    attr_accessor :id

    attr_accessor :signature

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :num_up

    attr_accessor :percent_usage

    attr_accessor :component_instance

    attr_accessor :content_estimate_part

    attr_accessor :sheets_required

    attr_accessor :alternate_print_method


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'signature' => :'signature',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'num_up' => :'numUp',
        :'percent_usage' => :'percentUsage',
        :'component_instance' => :'componentInstance',
        :'content_estimate_part' => :'contentEstimatePart',
        :'sheets_required' => :'sheetsRequired',
        :'alternate_print_method' => :'alternatePrintMethod'
      }
    end
  end
end
