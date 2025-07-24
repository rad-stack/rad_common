module Pace
  class EstimateRequestNote < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :item_template

    attr_accessor :note

    attr_accessor :customer_viewable

    attr_accessor :department

    attr_accessor :created_date_time

    attr_accessor :created_by

    attr_accessor :estimate_request_part

    attr_accessor :sub_note_category


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'item_template' => :'itemTemplate',
        :'note' => :'note',
        :'customer_viewable' => :'customerViewable',
        :'department' => :'department',
        :'created_date_time' => :'createdDateTime',
        :'created_by' => :'createdBy',
        :'estimate_request_part' => :'estimateRequestPart',
        :'sub_note_category' => :'subNoteCategory'
      }
    end
  end
end
