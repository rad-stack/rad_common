module Pace
  class BillLine < Base
    attr_accessor :id

    attr_accessor :component

    attr_accessor :po_uom

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :job_part_key

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :posted

    attr_accessor :original_id

    attr_accessor :discount_amount

    attr_accessor :invoice_amount

    attr_accessor :gl_account

    attr_accessor :tax_amount

    attr_accessor :non_planned_reason

    attr_accessor :activity_code

    attr_accessor :asset_tran_type

    attr_accessor :purchase_order_receipt

    attr_accessor :discount_applicable

    attr_accessor :taxed_basis

    attr_accessor :fixed_asset_id

    attr_accessor :tax_report_month

    attr_accessor :creation_source

    attr_accessor :po_tax_line

    attr_accessor :bill

    attr_accessor :tax_code

    attr_accessor :po_quantity

    attr_accessor :po_unit_price


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'component' => :'component',
        :'po_uom' => :'poUom',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'gl_department' => :'glDepartment',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'job_part_key' => :'jobPartKey',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'posted' => :'posted',
        :'original_id' => :'originalId',
        :'discount_amount' => :'discountAmount',
        :'invoice_amount' => :'invoiceAmount',
        :'gl_account' => :'glAccount',
        :'tax_amount' => :'taxAmount',
        :'non_planned_reason' => :'nonPlannedReason',
        :'activity_code' => :'activityCode',
        :'asset_tran_type' => :'assetTranType',
        :'purchase_order_receipt' => :'purchaseOrderReceipt',
        :'discount_applicable' => :'discountApplicable',
        :'taxed_basis' => :'taxedBasis',
        :'fixed_asset_id' => :'fixedAssetID',
        :'tax_report_month' => :'taxReportMonth',
        :'creation_source' => :'creationSource',
        :'po_tax_line' => :'poTaxLine',
        :'bill' => :'bill',
        :'tax_code' => :'taxCode',
        :'po_quantity' => :'poQuantity',
        :'po_unit_price' => :'poUnitPrice'
      }
    end
  end
end
