module Pace
  class CampaignNote < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :note

    attr_accessor :created_date_time

    attr_accessor :created_by

    attr_accessor :campaign


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'note' => :'note',
        :'created_date_time' => :'createdDateTime',
        :'created_by' => :'createdBy',
        :'campaign' => :'campaign'
      }
    end
  end
end
