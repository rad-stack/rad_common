module Pace
  class InvoiceSource < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :job_material

    attr_accessor :job_product

    attr_accessor :job_part_item

    attr_accessor :job_discount

    attr_accessor :source_target

    attr_accessor :job_part_overs_key

    attr_accessor :invoice_extra

    attr_accessor :job_cost

    attr_accessor :change_order_line

    attr_accessor :invoice_line

    attr_accessor :invoice

    attr_accessor :job_part_overs

    attr_accessor :change_order


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'job_material' => :'jobMaterial',
        :'job_product' => :'jobProduct',
        :'job_part_item' => :'jobPartItem',
        :'job_discount' => :'jobDiscount',
        :'source_target' => :'sourceTarget',
        :'job_part_overs_key' => :'jobPartOversKey',
        :'invoice_extra' => :'invoiceExtra',
        :'job_cost' => :'jobCost',
        :'change_order_line' => :'changeOrderLine',
        :'invoice_line' => :'invoiceLine',
        :'invoice' => :'invoice',
        :'job_part_overs' => :'jobPartOvers',
        :'change_order' => :'changeOrder'
      }
    end
  end
end
