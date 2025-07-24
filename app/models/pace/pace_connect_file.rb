module Pace
  class PaceConnectFile < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :pace_connect_generated

    attr_accessor :pace_connect

    attr_accessor :pace_connect_file_name

    attr_accessor :pace_connect_file_size

    attr_accessor :pace_connect_file_extension

    attr_accessor :pace_connect_file_source

    attr_accessor :file_suffix

    attr_accessor :pace_connect_file_date_format

    attr_accessor :file_prefix

    attr_accessor :velocity_template

    attr_accessor :file_mime_type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'pace_connect_generated' => :'paceConnectGenerated',
        :'pace_connect' => :'paceConnect',
        :'pace_connect_file_name' => :'paceConnectFileName',
        :'pace_connect_file_size' => :'paceConnectFileSize',
        :'pace_connect_file_extension' => :'paceConnectFileExtension',
        :'pace_connect_file_source' => :'paceConnectFileSource',
        :'file_suffix' => :'fileSuffix',
        :'pace_connect_file_date_format' => :'paceConnectFileDateFormat',
        :'file_prefix' => :'filePrefix',
        :'velocity_template' => :'velocityTemplate',
        :'file_mime_type' => :'fileMimeType'
      }
    end
  end
end
