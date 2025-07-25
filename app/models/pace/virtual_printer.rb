module Pace
  class VirtualPrinter < Base
    attr_accessor :name

    attr_accessor :value

    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :press

    attr_accessor :job_presets


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'value' => :'value',
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'press' => :'press',
        :'job_presets' => :'jobPresets'
      }
    end
  end
end
