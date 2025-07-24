module Pace
  class Keypad < Base
    attr_accessor :id

    attr_accessor :language

    attr_accessor :variant

    attr_accessor :country

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :keypad

    attr_accessor :network


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'language' => :'language',
        :'variant' => :'variant',
        :'country' => :'country',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'keypad' => :'keypad',
        :'network' => :'network'
      }
    end
  end
end
