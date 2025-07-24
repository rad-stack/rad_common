module Pace
  class Link < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :link

    attr_accessor :note

    attr_accessor :base_object

    attr_accessor :attachment_category

    attr_accessor :created_date_time

    attr_accessor :created_by

    attr_accessor :base_object_key


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'link' => :'link',
        :'note' => :'note',
        :'base_object' => :'baseObject',
        :'attachment_category' => :'attachmentCategory',
        :'created_date_time' => :'createdDateTime',
        :'created_by' => :'createdBy',
        :'base_object_key' => :'baseObjectKey'
      }
    end
  end
end
