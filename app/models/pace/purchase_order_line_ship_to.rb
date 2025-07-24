module Pace
  class PurchaseOrderLineShipTo < Base
    attr_accessor :id

    attr_accessor :state

    attr_accessor :country

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :contact_last_name

    attr_accessor :contact_first_name

    attr_accessor :state_key

    attr_accessor :phone_number

    attr_accessor :salutation

    attr_accessor :zip

    attr_accessor :city

    attr_accessor :ship_to_contact

    attr_accessor :address3

    attr_accessor :address2

    attr_accessor :address1

    attr_accessor :fax_number

    attr_accessor :qty_ordered

    attr_accessor :purchase_order_line

    attr_accessor :date_required

    attr_accessor :time_required

    attr_accessor :company_name

    attr_accessor :email_address


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'state' => :'state',
        :'country' => :'country',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'contact_last_name' => :'contactLastName',
        :'contact_first_name' => :'contactFirstName',
        :'state_key' => :'stateKey',
        :'phone_number' => :'phoneNumber',
        :'salutation' => :'salutation',
        :'zip' => :'zip',
        :'city' => :'city',
        :'ship_to_contact' => :'shipToContact',
        :'address3' => :'address3',
        :'address2' => :'address2',
        :'address1' => :'address1',
        :'fax_number' => :'faxNumber',
        :'qty_ordered' => :'qtyOrdered',
        :'purchase_order_line' => :'purchaseOrderLine',
        :'date_required' => :'dateRequired',
        :'time_required' => :'timeRequired',
        :'company_name' => :'companyName',
        :'email_address' => :'emailAddress'
      }
    end
  end
end
