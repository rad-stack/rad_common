module Pace
  class ContentFile < Base
    attr_accessor :id

    attr_accessor :file_name

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :network_location

    attr_accessor :customer

    attr_accessor :page_count

    attr_accessor :file_type

    attr_accessor :updated_date_time

    attr_accessor :file_size

    attr_accessor :file_url


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'file_name' => :'fileName',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'network_location' => :'networkLocation',
        :'customer' => :'customer',
        :'page_count' => :'pageCount',
        :'file_type' => :'fileType',
        :'updated_date_time' => :'updatedDateTime',
        :'file_size' => :'fileSize',
        :'file_url' => :'fileUrl'
      }
    end
  end
end
