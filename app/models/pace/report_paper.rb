module Pace
  class ReportPaper < Base
    attr_accessor :name

    attr_accessor :length

    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :width

    attr_accessor :width_display_uom

    attr_accessor :length_display_uom

    attr_accessor :report_settings


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'length' => :'length',
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'width' => :'width',
        :'width_display_uom' => :'widthDisplayUOM',
        :'length_display_uom' => :'lengthDisplayUOM',
        :'report_settings' => :'reportSettings'
      }
    end
  end
end
