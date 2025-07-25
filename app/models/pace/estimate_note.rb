module Pace
  class EstimateNote < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :note

    attr_accessor :estimate_part

    attr_accessor :customer_viewable

    attr_accessor :department

    attr_accessor :estimate_quantity

    attr_accessor :created_date_time

    attr_accessor :created_by

    attr_accessor :sub_note_category

    attr_accessor :convert_to_job


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'note' => :'note',
        :'estimate_part' => :'estimatePart',
        :'customer_viewable' => :'customerViewable',
        :'department' => :'department',
        :'estimate_quantity' => :'estimateQuantity',
        :'created_date_time' => :'createdDateTime',
        :'created_by' => :'createdBy',
        :'sub_note_category' => :'subNoteCategory',
        :'convert_to_job' => :'convertToJob'
      }
    end
  end
end
