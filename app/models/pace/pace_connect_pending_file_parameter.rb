module Pace
  class PaceConnectPendingFileParameter < Base
    attr_accessor :name

    attr_accessor :value

    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :pace_connect_pending_file


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'value' => :'value',
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'pace_connect_pending_file' => :'paceConnectPendingFile'
      }
    end
  end
end
