module Pace
  class ShippingAppSettings < Base
    attr_accessor :id

    attr_accessor :user_name

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :department

    attr_accessor :disclaimer

    attr_accessor :image_attachment_category

    attr_accessor :signature_attachment_category


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'user_name' => :'userName',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'department' => :'department',
        :'disclaimer' => :'disclaimer',
        :'image_attachment_category' => :'imageAttachmentCategory',
        :'signature_attachment_category' => :'signatureAttachmentCategory'
      }
    end
  end
end
