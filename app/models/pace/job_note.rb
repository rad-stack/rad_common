module Pace
  class JobNote < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :crm_id

    attr_accessor :item_template

    attr_accessor :note

    attr_accessor :customer_viewable

    attr_accessor :department

    attr_accessor :created_date_time

    attr_accessor :created_by

    attr_accessor :job_plan

    attr_accessor :note_summary

    attr_accessor :from_estimating

    attr_accessor :sub_note_category

    attr_accessor :from_quote

    attr_accessor :job_job_part


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'crm_id' => :'crmId',
        :'item_template' => :'itemTemplate',
        :'note' => :'note',
        :'customer_viewable' => :'customerViewable',
        :'department' => :'department',
        :'created_date_time' => :'createdDateTime',
        :'created_by' => :'createdBy',
        :'job_plan' => :'jobPlan',
        :'note_summary' => :'noteSummary',
        :'from_estimating' => :'fromEstimating',
        :'sub_note_category' => :'subNoteCategory',
        :'from_quote' => :'fromQuote',
        :'job_job_part' => :'jobJobPart'
      }
    end
  end
end
