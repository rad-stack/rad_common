module Pace
  class PurchaseOrder < Base
    attr_accessor :id

    attr_accessor :state

    attr_accessor :country

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :contact_last_name

    attr_accessor :contact_first_name

    attr_accessor :state_key

    attr_accessor :phone_number

    attr_accessor :salutation

    attr_accessor :ship_via

    attr_accessor :dsf_shared

    attr_accessor :terms

    attr_accessor :zip

    attr_accessor :city

    attr_accessor :print_stream_shared

    attr_accessor :ship_to_contact

    attr_accessor :manufacturing_location

    attr_accessor :address3

    attr_accessor :address2

    attr_accessor :address1

    attr_accessor :fax_number

    attr_accessor :customer

    attr_accessor :discount_amount

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :po_number

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :vendor

    attr_accessor :alt_currency_rate_source

    attr_accessor :created_by

    attr_accessor :tax_amount1

    attr_accessor :tax_amount2

    attr_accessor :date_entered

    attr_accessor :tax_base2

    attr_accessor :tax_base1

    attr_accessor :company_name

    attr_accessor :original_total

    attr_accessor :revision_number

    attr_accessor :freight_on_board

    attr_accessor :email_address

    attr_accessor :confirmed_by

    attr_accessor :requester

    attr_accessor :po_shared

    attr_accessor :receive_date

    attr_accessor :buyer

    attr_accessor :authorization_requested

    attr_accessor :revision_date

    attr_accessor :order_status

    attr_accessor :taxed_total

    attr_accessor :date_confirmed

    attr_accessor :ship_to_is_cust

    attr_accessor :date_last_receipt

    attr_accessor :vendor_contact

    attr_accessor :order_total

    attr_accessor :authorized_by

    attr_accessor :discount_code

    attr_accessor :purchase_order_type

    attr_accessor :total_lines

    attr_accessor :convert_entered_values


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'state' => :'state',
        :'country' => :'country',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'contact_last_name' => :'contactLastName',
        :'contact_first_name' => :'contactFirstName',
        :'state_key' => :'stateKey',
        :'phone_number' => :'phoneNumber',
        :'salutation' => :'salutation',
        :'ship_via' => :'shipVia',
        :'dsf_shared' => :'dsfShared',
        :'terms' => :'terms',
        :'zip' => :'zip',
        :'city' => :'city',
        :'print_stream_shared' => :'printStreamShared',
        :'ship_to_contact' => :'shipToContact',
        :'manufacturing_location' => :'manufacturingLocation',
        :'address3' => :'address3',
        :'address2' => :'address2',
        :'address1' => :'address1',
        :'fax_number' => :'faxNumber',
        :'customer' => :'customer',
        :'discount_amount' => :'discountAmount',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'po_number' => :'poNumber',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'vendor' => :'vendor',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'created_by' => :'createdBy',
        :'tax_amount1' => :'taxAmount1',
        :'tax_amount2' => :'taxAmount2',
        :'date_entered' => :'dateEntered',
        :'tax_base2' => :'taxBase2',
        :'tax_base1' => :'taxBase1',
        :'company_name' => :'companyName',
        :'original_total' => :'originalTotal',
        :'revision_number' => :'revisionNumber',
        :'freight_on_board' => :'freightOnBoard',
        :'email_address' => :'emailAddress',
        :'confirmed_by' => :'confirmedBy',
        :'requester' => :'requester',
        :'po_shared' => :'poShared',
        :'receive_date' => :'receiveDate',
        :'buyer' => :'buyer',
        :'authorization_requested' => :'authorizationRequested',
        :'revision_date' => :'revisionDate',
        :'order_status' => :'orderStatus',
        :'taxed_total' => :'taxedTotal',
        :'date_confirmed' => :'dateConfirmed',
        :'ship_to_is_cust' => :'shipToIsCust',
        :'date_last_receipt' => :'dateLastReceipt',
        :'vendor_contact' => :'vendorContact',
        :'order_total' => :'orderTotal',
        :'authorized_by' => :'authorizedBy',
        :'discount_code' => :'discountCode',
        :'purchase_order_type' => :'purchaseOrderType',
        :'total_lines' => :'totalLines',
        :'convert_entered_values' => :'convertEnteredValues'
      }
    end
  end
end
