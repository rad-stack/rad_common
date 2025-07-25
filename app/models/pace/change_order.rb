module Pace
  class ChangeOrder < Base
    attr_accessor :id

    attr_accessor :type

    attr_accessor :description

    attr_accessor :component

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :entered_by

    attr_accessor :external_id

    attr_accessor :department

    attr_accessor :tax_base

    attr_accessor :tax_amount

    attr_accessor :non_planned_reason

    attr_accessor :entry_date_time

    attr_accessor :invoice

    attr_accessor :due_date_time

    attr_accessor :authorized_by

    attr_accessor :po_num

    attr_accessor :job_order_id

    attr_accessor :total_nc_amt

    attr_accessor :reference_id

    attr_accessor :order_item_id

    attr_accessor :num

    attr_accessor :revision_num

    attr_accessor :billed

    attr_accessor :total_bill_amt


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'type' => :'type',
        :'description' => :'description',
        :'component' => :'component',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'entered_by' => :'enteredBy',
        :'external_id' => :'externalID',
        :'department' => :'department',
        :'tax_base' => :'taxBase',
        :'tax_amount' => :'taxAmount',
        :'non_planned_reason' => :'nonPlannedReason',
        :'entry_date_time' => :'entryDateTime',
        :'invoice' => :'invoice',
        :'due_date_time' => :'dueDateTime',
        :'authorized_by' => :'authorizedBy',
        :'po_num' => :'poNum',
        :'job_order_id' => :'jobOrderID',
        :'total_nc_amt' => :'totalNCAmt',
        :'reference_id' => :'referenceID',
        :'order_item_id' => :'orderItemID',
        :'num' => :'num',
        :'revision_num' => :'revisionNum',
        :'billed' => :'billed',
        :'total_bill_amt' => :'totalBillAmt'
      }
    end
  end
end
