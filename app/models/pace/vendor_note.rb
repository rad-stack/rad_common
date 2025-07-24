module Pace
  class VendorNote < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :note

    attr_accessor :vendor

    attr_accessor :created_date_time

    attr_accessor :created_by


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'category' => :'category',
        :'note' => :'note',
        :'vendor' => :'vendor',
        :'created_date_time' => :'createdDateTime',
        :'created_by' => :'createdBy'
      }
    end
  end
end
