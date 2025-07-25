module Pace
  class ReportFile < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :created_by

    attr_accessor :date_created

    attr_accessor :name_forced

    attr_accessor :efi_owned


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'created_by' => :'createdBy',
        :'date_created' => :'dateCreated',
        :'name_forced' => :'nameForced',
        :'efi_owned' => :'efiOwned'
      }
    end
  end
end
