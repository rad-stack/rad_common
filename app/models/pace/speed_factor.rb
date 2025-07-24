module Pace
  class SpeedFactor < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :key4

    attr_accessor :key1

    attr_accessor :key2

    attr_accessor :key3


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'key4' => :'key4',
        :'key1' => :'key1',
        :'key2' => :'key2',
        :'key3' => :'key3'
      }
    end
  end
end
