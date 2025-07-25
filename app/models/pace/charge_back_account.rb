module Pace
  class ChargeBackAccount < Base
    attr_accessor :id

    attr_accessor :status

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :contact_last_name

    attr_accessor :contact_first_name

    attr_accessor :salutation

    attr_accessor :customer

    attr_accessor :expiration_date

    attr_accessor :account_number

    attr_accessor :is_dsf_expired


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'status' => :'status',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'contact_last_name' => :'contactLastName',
        :'contact_first_name' => :'contactFirstName',
        :'salutation' => :'salutation',
        :'customer' => :'customer',
        :'expiration_date' => :'expirationDate',
        :'account_number' => :'accountNumber',
        :'is_dsf_expired' => :'isDSFExpired'
      }
    end
  end
end
