module Pace
  class ReportPrinter < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :language

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :expression_type

    attr_accessor :printer

    attr_accessor :report

    attr_accessor :duplex_mode

    attr_accessor :condition

    attr_accessor :language_region

    attr_accessor :paper_size

    attr_accessor :tray

    attr_accessor :color_mode

    attr_accessor :size_policy

    attr_accessor :preferred_media_attribute

    attr_accessor :printer_settings


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'language' => :'language',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'expression_type' => :'expressionType',
        :'printer' => :'printer',
        :'report' => :'report',
        :'duplex_mode' => :'duplexMode',
        :'condition' => :'condition',
        :'language_region' => :'languageRegion',
        :'paper_size' => :'paperSize',
        :'tray' => :'tray',
        :'color_mode' => :'colorMode',
        :'size_policy' => :'sizePolicy',
        :'preferred_media_attribute' => :'preferredMediaAttribute',
        :'printer_settings' => :'printerSettings'
      }
    end
  end
end
