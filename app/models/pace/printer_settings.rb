module Pace
  class PrinterSettings < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :language

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :printer

    attr_accessor :duplex_mode

    attr_accessor :language_region

    attr_accessor :paper_size

    attr_accessor :tray

    attr_accessor :color_mode

    attr_accessor :size_policy


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'language' => :'language',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'printer' => :'printer',
        :'duplex_mode' => :'duplexMode',
        :'language_region' => :'languageRegion',
        :'paper_size' => :'paperSize',
        :'tray' => :'tray',
        :'color_mode' => :'colorMode',
        :'size_policy' => :'sizePolicy'
      }
    end
  end
end
