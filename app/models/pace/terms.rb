module Pace
  class Terms < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :discount_percent

    attr_accessor :note

    attr_accessor :alt_description

    attr_accessor :months_added_to_invoice_date

    attr_accessor :discount_day_till_due

    attr_accessor :days_after_end_of_month

    attr_accessor :end_of_month

    attr_accessor :days_till_due

    attr_accessor :day_method


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
        :'discount_percent' => :'discountPercent',
        :'note' => :'note',
        :'alt_description' => :'altDescription',
        :'months_added_to_invoice_date' => :'monthsAddedToInvoiceDate',
        :'discount_day_till_due' => :'discountDayTillDue',
        :'days_after_end_of_month' => :'daysAfterEndOfMonth',
        :'end_of_month' => :'endOfMonth',
        :'days_till_due' => :'daysTillDue',
        :'day_method' => :'dayMethod'
      }
    end
  end
end
