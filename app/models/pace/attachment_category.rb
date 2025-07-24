module Pace
  class AttachmentCategory < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :type

    attr_accessor :object

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :available_in_shipping_app

    attr_accessor :object_category


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'type' => :'type',
        :'object' => :'object',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'available_in_shipping_app' => :'availableInShippingApp',
        :'object_category' => :'objectCategory'
      }
    end
  end
end
