module Pace
  class CustomerType < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :gl_account

    attr_accessor :prospect

    attr_accessor :default_unapplied_credit_account

    attr_accessor :auto_post_no_payment_due_invoices

    attr_accessor :customer_type_aging_total

    attr_accessor :auto_post_invoices_below

    attr_accessor :auto_post_all_invoices

    attr_accessor :default_unapplied_payment_sales_category


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'gl_account' => :'glAccount',
        :'prospect' => :'prospect',
        :'default_unapplied_credit_account' => :'defaultUnappliedCreditAccount',
        :'auto_post_no_payment_due_invoices' => :'autoPostNoPaymentDueInvoices',
        :'customer_type_aging_total' => :'customerTypeAgingTotal',
        :'auto_post_invoices_below' => :'autoPostInvoicesBelow',
        :'auto_post_all_invoices' => :'autoPostAllInvoices',
        :'default_unapplied_payment_sales_category' => :'defaultUnappliedPaymentSalesCategory'
      }
    end
  end
end
