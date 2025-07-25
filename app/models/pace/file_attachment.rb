module Pace
  class FileAttachment < Base
    attr_accessor :name

    attr_accessor :field

    attr_accessor :size

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :manual

    attr_accessor :note

    attr_accessor :base_object

    attr_accessor :attachment_category

    attr_accessor :created_date_time

    attr_accessor :created_by

    attr_accessor :base_object_key

    attr_accessor :mime_type

    attr_accessor :ext

    attr_accessor :local_file_attachment

    attr_accessor :display_size

    attr_accessor :generated_for_email


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'field' => :'field',
        :'size' => :'size',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'manual' => :'manual',
        :'note' => :'note',
        :'base_object' => :'baseObject',
        :'attachment_category' => :'attachmentCategory',
        :'created_date_time' => :'createdDateTime',
        :'created_by' => :'createdBy',
        :'base_object_key' => :'baseObjectKey',
        :'mime_type' => :'mimeType',
        :'ext' => :'ext',
        :'local_file_attachment' => :'localFileAttachment',
        :'display_size' => :'displaySize',
        :'generated_for_email' => :'generatedForEmail'
      }
    end
  end
end
