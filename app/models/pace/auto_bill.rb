module Pace
  class AutoBill < Base
    attr_accessor :reference

    attr_accessor :id

    attr_accessor :comments

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :terms

    attr_accessor :vendor

    attr_accessor :bill_status

    attr_accessor :bill_day

    attr_accessor :auto_bill_amount


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'reference' => :'reference',
        :'id' => :'id',
        :'comments' => :'comments',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'terms' => :'terms',
        :'vendor' => :'vendor',
        :'bill_status' => :'billStatus',
        :'bill_day' => :'billDay',
        :'auto_bill_amount' => :'autoBillAmount'
      }
    end
  end
end
