module Pace
  class ProductOrder < Base
    attr_accessor :reference

    attr_accessor :id

    attr_accessor :state

    attr_accessor :country

    attr_accessor :option

    attr_accessor :status

    attr_accessor :comments

    attr_accessor :email

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :state_key

    attr_accessor :salutation

    attr_accessor :ship_via

    attr_accessor :zip

    attr_accessor :city

    attr_accessor :ship_to_contact

    attr_accessor :address3

    attr_accessor :address2

    attr_accessor :address1

    attr_accessor :quantity

    attr_accessor :price

    attr_accessor :phone

    attr_accessor :unit_price

    attr_accessor :product

    attr_accessor :purchase_order

    attr_accessor :total_price

    attr_accessor :estimate_version

    attr_accessor :date_required

    attr_accessor :shopping_cart

    attr_accessor :tax

    attr_accessor :estimate_number

    attr_accessor :extra_amount

    attr_accessor :freight

    attr_accessor :converted_job_type

    attr_accessor :remove

    attr_accessor :template_data

    attr_accessor :field17

    attr_accessor :field18

    attr_accessor :field20

    attr_accessor :option_price

    attr_accessor :customer_entered

    attr_accessor :field11

    attr_accessor :field12

    attr_accessor :user_entered

    attr_accessor :field10

    attr_accessor :field15

    attr_accessor :field16

    attr_accessor :field13

    attr_accessor :field14

    attr_accessor :customer_approved

    attr_accessor :attention_first_name

    attr_accessor :attention_last_name

    attr_accessor :date_time_entered

    attr_accessor :field1

    attr_accessor :field7

    attr_accessor :field6

    attr_accessor :field9

    attr_accessor :field8

    attr_accessor :field3

    attr_accessor :field2

    attr_accessor :user_approved

    attr_accessor :field5

    attr_accessor :field4

    attr_accessor :field19


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'reference' => :'reference',
        :'id' => :'id',
        :'state' => :'state',
        :'country' => :'country',
        :'option' => :'option',
        :'status' => :'status',
        :'comments' => :'comments',
        :'email' => :'email',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'state_key' => :'stateKey',
        :'salutation' => :'salutation',
        :'ship_via' => :'shipVia',
        :'zip' => :'zip',
        :'city' => :'city',
        :'ship_to_contact' => :'shipToContact',
        :'address3' => :'address3',
        :'address2' => :'address2',
        :'address1' => :'address1',
        :'quantity' => :'quantity',
        :'price' => :'price',
        :'phone' => :'phone',
        :'unit_price' => :'unitPrice',
        :'product' => :'product',
        :'purchase_order' => :'purchaseOrder',
        :'total_price' => :'totalPrice',
        :'estimate_version' => :'estimateVersion',
        :'date_required' => :'dateRequired',
        :'shopping_cart' => :'shoppingCart',
        :'tax' => :'tax',
        :'estimate_number' => :'estimateNumber',
        :'extra_amount' => :'extraAmount',
        :'freight' => :'freight',
        :'converted_job_type' => :'convertedJobType',
        :'remove' => :'remove',
        :'template_data' => :'templateData',
        :'field17' => :'field17',
        :'field18' => :'field18',
        :'field20' => :'field20',
        :'option_price' => :'optionPrice',
        :'customer_entered' => :'customerEntered',
        :'field11' => :'field11',
        :'field12' => :'field12',
        :'user_entered' => :'userEntered',
        :'field10' => :'field10',
        :'field15' => :'field15',
        :'field16' => :'field16',
        :'field13' => :'field13',
        :'field14' => :'field14',
        :'customer_approved' => :'customerApproved',
        :'attention_first_name' => :'attentionFirstName',
        :'attention_last_name' => :'attentionLastName',
        :'date_time_entered' => :'dateTimeEntered',
        :'field1' => :'field1',
        :'field7' => :'field7',
        :'field6' => :'field6',
        :'field9' => :'field9',
        :'field8' => :'field8',
        :'field3' => :'field3',
        :'field2' => :'field2',
        :'user_approved' => :'userApproved',
        :'field5' => :'field5',
        :'field4' => :'field4',
        :'field19' => :'field19'
      }
    end
  end
end
