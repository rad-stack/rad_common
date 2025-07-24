module Pace
  class PaperTypeActivity < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :manufacturing_location

    attr_accessor :activity_code

    attr_accessor :make_ready_activity_code

    attr_accessor :paper_type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'manufacturing_location' => :'manufacturingLocation',
        :'activity_code' => :'activityCode',
        :'make_ready_activity_code' => :'makeReadyActivityCode',
        :'paper_type' => :'paperType'
      }
    end
  end
end
