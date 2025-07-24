module Pace
  class UserDefinedInquiryContextMenuObject < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :user_defined_inquiry

    attr_accessor :context_menu_base_object


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'user_defined_inquiry' => :'userDefinedInquiry',
        :'context_menu_base_object' => :'contextMenuBaseObject'
      }
    end
  end
end
