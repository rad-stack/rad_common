module Pace
  class JobReorder < Base
    attr_accessor :reference

    attr_accessor :id

    attr_accessor :state

    attr_accessor :comment

    attr_accessor :ordered

    attr_accessor :country

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :state_key

    attr_accessor :zip

    attr_accessor :city

    attr_accessor :ship_to_contact

    attr_accessor :address3

    attr_accessor :address2

    attr_accessor :address1

    attr_accessor :quantity

    attr_accessor :entered_by

    attr_accessor :customer

    attr_accessor :phone

    attr_accessor :purchase_order

    attr_accessor :date_entered

    attr_accessor :date_required

    attr_accessor :company_name

    attr_accessor :attention


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'reference' => :'reference',
        :'id' => :'id',
        :'state' => :'state',
        :'comment' => :'comment',
        :'ordered' => :'ordered',
        :'country' => :'country',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'state_key' => :'stateKey',
        :'zip' => :'zip',
        :'city' => :'city',
        :'ship_to_contact' => :'shipToContact',
        :'address3' => :'address3',
        :'address2' => :'address2',
        :'address1' => :'address1',
        :'quantity' => :'quantity',
        :'entered_by' => :'enteredBy',
        :'customer' => :'customer',
        :'phone' => :'phone',
        :'purchase_order' => :'purchaseOrder',
        :'date_entered' => :'dateEntered',
        :'date_required' => :'dateRequired',
        :'company_name' => :'companyName',
        :'attention' => :'attention'
      }
    end
  end
end
