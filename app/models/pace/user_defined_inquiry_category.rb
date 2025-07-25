module Pace
  class UserDefinedInquiryCategory < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :group

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category_type

    attr_accessor :user


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'group' => :'group',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'category_type' => :'categoryType',
        :'user' => :'user'
      }
    end
  end
end
