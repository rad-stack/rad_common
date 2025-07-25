module Pace
  class ImportTemplate < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :headers

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :system_generated

    attr_accessor :base_object

    attr_accessor :created_date

    attr_accessor :created_by

    attr_accessor :sheet_name

    attr_accessor :context_object

    attr_accessor :save_all_success_full_records

    attr_accessor :wizard_generated

    attr_accessor :date_last_used

    attr_accessor :context_object_instance

    attr_accessor :file_type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'headers' => :'headers',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'category' => :'category',
        :'system_generated' => :'systemGenerated',
        :'base_object' => :'baseObject',
        :'created_date' => :'createdDate',
        :'created_by' => :'createdBy',
        :'sheet_name' => :'sheetName',
        :'context_object' => :'contextObject',
        :'save_all_success_full_records' => :'saveAllSuccessFullRecords',
        :'wizard_generated' => :'wizardGenerated',
        :'date_last_used' => :'dateLastUsed',
        :'context_object_instance' => :'contextObjectInstance',
        :'file_type' => :'fileType'
      }
    end
  end
end
