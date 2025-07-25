module Pace
  class GLScheduleLine < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :gl_account

    attr_accessor :glschedule

    attr_accessor :report_underline_style

    attr_accessor :order_location


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'gl_account' => :'glAccount',
        :'glschedule' => :'glschedule',
        :'report_underline_style' => :'reportUnderlineStyle',
        :'order_location' => :'orderLocation'
      }
    end
  end
end
