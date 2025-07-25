module Pace
  class PaymentMethod < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :account

    attr_accessor :chargeback_account

    attr_accessor :credit_card_processing

    attr_accessor :porequired


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'account' => :'account',
        :'chargeback_account' => :'chargebackAccount',
        :'credit_card_processing' => :'creditCardProcessing',
        :'porequired' => :'porequired'
      }
    end
  end
end
