module Pace
  class PrinterPaperMapping < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :printer

    attr_accessor :printer_media_attribute

    attr_accessor :paper_size


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'printer' => :'printer',
        :'printer_media_attribute' => :'printerMediaAttribute',
        :'paper_size' => :'paperSize'
      }
    end
  end
end
