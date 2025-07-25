module Pace
  class FinGoodsOrder < Base
    attr_accessor :id

    attr_accessor :comment

    attr_accessor :status

    attr_accessor :comments

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :state_key

    attr_accessor :salutation

    attr_accessor :ship_via

    attr_accessor :ship_to_contact

    attr_accessor :quantity

    attr_accessor :entered_by

    attr_accessor :price

    attr_accessor :customer

    attr_accessor :inventory_item

    attr_accessor :po_number

    attr_accessor :total_price

    attr_accessor :date_entered

    attr_accessor :date_required

    attr_accessor :shopping_cart

    attr_accessor :tax

    attr_accessor :extra_amount

    attr_accessor :order_id

    attr_accessor :freight

    attr_accessor :ship_to_company

    attr_accessor :converted_job_type

    attr_accessor :remove

    attr_accessor :ship_to_city

    attr_accessor :ship_to_zip

    attr_accessor :ship_to_attn_first_name

    attr_accessor :ship_to_state

    attr_accessor :ship_to_phone

    attr_accessor :ship_to_country

    attr_accessor :ship_to_address3

    attr_accessor :ref_number

    attr_accessor :ship_to_address1

    attr_accessor :remove_cart

    attr_accessor :ship_to_address2

    attr_accessor :ship_to_attn_last_name


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'comment' => :'comment',
        :'status' => :'status',
        :'comments' => :'comments',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'state_key' => :'stateKey',
        :'salutation' => :'salutation',
        :'ship_via' => :'shipVia',
        :'ship_to_contact' => :'shipToContact',
        :'quantity' => :'quantity',
        :'entered_by' => :'enteredBy',
        :'price' => :'price',
        :'customer' => :'customer',
        :'inventory_item' => :'inventoryItem',
        :'po_number' => :'poNumber',
        :'total_price' => :'totalPrice',
        :'date_entered' => :'dateEntered',
        :'date_required' => :'dateRequired',
        :'shopping_cart' => :'shoppingCart',
        :'tax' => :'tax',
        :'extra_amount' => :'extraAmount',
        :'order_id' => :'orderId',
        :'freight' => :'freight',
        :'ship_to_company' => :'shipToCompany',
        :'converted_job_type' => :'convertedJobType',
        :'remove' => :'remove',
        :'ship_to_city' => :'shipToCity',
        :'ship_to_zip' => :'shipToZip',
        :'ship_to_attn_first_name' => :'shipToAttnFirstName',
        :'ship_to_state' => :'shipToState',
        :'ship_to_phone' => :'shipToPhone',
        :'ship_to_country' => :'shipToCountry',
        :'ship_to_address3' => :'shipToAddress3',
        :'ref_number' => :'refNumber',
        :'ship_to_address1' => :'shipToAddress1',
        :'remove_cart' => :'removeCart',
        :'ship_to_address2' => :'shipToAddress2',
        :'ship_to_attn_last_name' => :'shipToAttnLastName'
      }
    end
  end
end
