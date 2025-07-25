module Pace
  class CustomerNote < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :note

    attr_accessor :customer

    attr_accessor :created_date_time

    attr_accessor :created_by

    attr_accessor :sub_note_category


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
        :'customer' => :'customer',
        :'created_date_time' => :'createdDateTime',
        :'created_by' => :'createdBy',
        :'sub_note_category' => :'subNoteCategory'
      }
    end
  end
end
