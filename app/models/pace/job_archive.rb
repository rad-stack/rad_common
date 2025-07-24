module Pace
  class JobArchive < Base
    attr_accessor :reference

    attr_accessor :id

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :invoice_date

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :sales_category

    attr_accessor :contact_last_name

    attr_accessor :contact_first_name

    attr_accessor :salutation

    attr_accessor :sales_person

    attr_accessor :ship_to_contact

    attr_accessor :gl_register_number

    attr_accessor :customer

    attr_accessor :original_id

    attr_accessor :inventory_item

    attr_accessor :invoice_amount

    attr_accessor :quoted_price

    attr_accessor :tax_base

    attr_accessor :tax_amount

    attr_accessor :cost

    attr_accessor :charge_back_account

    attr_accessor :colors_s2

    attr_accessor :colors_s1

    attr_accessor :colors_total

    attr_accessor :qty_ordered

    attr_accessor :estimated_cost

    attr_accessor :edit_flag

    attr_accessor :commission_base

    attr_accessor :qty_shipped

    attr_accessor :pages

    attr_accessor :form_num

    attr_accessor :ink_desc_s1

    attr_accessor :ink_desc_s2

    attr_accessor :edit_date

    attr_accessor :actual_ship_date

    attr_accessor :press1

    attr_accessor :press2

    attr_accessor :job_product_type

    attr_accessor :previous_job_num

    attr_accessor :invoice_num

    attr_accessor :promise_date

    attr_accessor :value_added

    attr_accessor :po_num

    attr_accessor :extra_amount

    attr_accessor :description2

    attr_accessor :acct_pd

    attr_accessor :plate_file_loc

    attr_accessor :ink_description

    attr_accessor :commission_amt

    attr_accessor :syc_auto_key

    attr_accessor :custr_code_ex

    attr_accessor :order_date


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'reference' => :'reference',
        :'id' => :'id',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'invoice_date' => :'invoiceDate',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'sales_category' => :'salesCategory',
        :'contact_last_name' => :'contactLastName',
        :'contact_first_name' => :'contactFirstName',
        :'salutation' => :'salutation',
        :'sales_person' => :'salesPerson',
        :'ship_to_contact' => :'shipToContact',
        :'gl_register_number' => :'glRegisterNumber',
        :'customer' => :'customer',
        :'original_id' => :'originalId',
        :'inventory_item' => :'inventoryItem',
        :'invoice_amount' => :'invoiceAmount',
        :'quoted_price' => :'quotedPrice',
        :'tax_base' => :'taxBase',
        :'tax_amount' => :'taxAmount',
        :'cost' => :'cost',
        :'charge_back_account' => :'chargeBackAccount',
        :'colors_s2' => :'colorsS2',
        :'colors_s1' => :'colorsS1',
        :'colors_total' => :'colorsTotal',
        :'qty_ordered' => :'qtyOrdered',
        :'estimated_cost' => :'estimatedCost',
        :'edit_flag' => :'editFlag',
        :'commission_base' => :'commissionBase',
        :'qty_shipped' => :'qtyShipped',
        :'pages' => :'pages',
        :'form_num' => :'formNum',
        :'ink_desc_s1' => :'inkDescS1',
        :'ink_desc_s2' => :'inkDescS2',
        :'edit_date' => :'editDate',
        :'actual_ship_date' => :'actualShipDate',
        :'press1' => :'press1',
        :'press2' => :'press2',
        :'job_product_type' => :'jobProductType',
        :'previous_job_num' => :'previousJobNum',
        :'invoice_num' => :'invoiceNum',
        :'promise_date' => :'promiseDate',
        :'value_added' => :'valueAdded',
        :'po_num' => :'poNum',
        :'extra_amount' => :'extraAmount',
        :'description2' => :'description2',
        :'acct_pd' => :'acctPd',
        :'plate_file_loc' => :'plateFileLoc',
        :'ink_description' => :'inkDescription',
        :'commission_amt' => :'commissionAmt',
        :'syc_auto_key' => :'sycAutoKey',
        :'custr_code_ex' => :'custrCodeEx',
        :'order_date' => :'orderDate'
      }
    end
  end
end
