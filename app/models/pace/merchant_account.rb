module Pace
  class MerchantAccount < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :payment_method

    attr_accessor :merchant_login

    attr_accessor :merchant_ship_state

    attr_accessor :merchant_ship_state_key

    attr_accessor :merchant_state

    attr_accessor :merchant_md5

    attr_accessor :merchant_name

    attr_accessor :merchant_minority_code

    attr_accessor :merchant_ship_country

    attr_accessor :merchant_transaction_key

    attr_accessor :merchant_postal_code

    attr_accessor :merchant_country

    attr_accessor :merchant_state_key


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'payment_method' => :'paymentMethod',
        :'merchant_login' => :'merchantLogin',
        :'merchant_ship_state' => :'merchantShipState',
        :'merchant_ship_state_key' => :'merchantShipStateKey',
        :'merchant_state' => :'merchantState',
        :'merchant_md5' => :'merchantMD5',
        :'merchant_name' => :'merchantName',
        :'merchant_minority_code' => :'merchantMinorityCode',
        :'merchant_ship_country' => :'merchantShipCountry',
        :'merchant_transaction_key' => :'merchantTransactionKey',
        :'merchant_postal_code' => :'merchantPostalCode',
        :'merchant_country' => :'merchantCountry',
        :'merchant_state_key' => :'merchantStateKey'
      }
    end
  end
end
