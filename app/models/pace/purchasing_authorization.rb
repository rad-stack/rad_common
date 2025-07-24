module Pace
  class PurchasingAuthorization < Base
    attr_accessor :id

    attr_accessor :time

    attr_accessor :date

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :entered_by

    attr_accessor :purchase_order

    attr_accessor :sent_to

    attr_accessor :response_note

    attr_accessor :response


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'time' => :'time',
        :'date' => :'date',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'entered_by' => :'enteredBy',
        :'purchase_order' => :'purchaseOrder',
        :'sent_to' => :'sentTo',
        :'response_note' => :'responseNote',
        :'response' => :'response'
      }
    end
  end
end
