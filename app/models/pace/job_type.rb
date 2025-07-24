module Pace
  class JobType < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_product_invoice_line_description

    attr_accessor :job_invoice_line_description

    attr_accessor :job_part_invoice_line_description

    attr_accessor :job_part_item_invoice_line_description

    attr_accessor :job_material_invoice_line_description

    attr_accessor :routing_template

    attr_accessor :use_manufacturing_location_prefix

    attr_accessor :auto_close_jobs

    attr_accessor :display_deposits

    attr_accessor :invoice_num_is_job_num

    attr_accessor :tax_distribution_source

    attr_accessor :separate_tax_distibution_for_rounding

    attr_accessor :create_job_part_work_folders

    attr_accessor :finish_good_invoice_description

    attr_accessor :jacket_type

    attr_accessor :auto_apply_deposits

    attr_accessor :auto_add_product

    attr_accessor :finished_good_invoice_method

    attr_accessor :job_number_sequence

    attr_accessor :job_part_item_invoice_description

    attr_accessor :create_job_part_folders

    attr_accessor :distribute_tax

    attr_accessor :auto_enter_overage

    attr_accessor :job_number_prefix

    attr_accessor :auto_enter_underage

    attr_accessor :create_mdff_order

    attr_accessor :display_part_items

    attr_accessor :use_invoice_description_from

    attr_accessor :archive_description

    attr_accessor :invoice_level_options

    attr_accessor :sales_distribution_method

    attr_accessor :consolidate_vat_tax_distributions

    attr_accessor :tax_distribution_method

    attr_accessor :sales_tax_basis

    attr_accessor :line_item_price_options

    attr_accessor :bill_parts_together_attribute

    attr_accessor :invoice_quantity

    attr_accessor :invoice_date_method

    attr_accessor :job_component_ratio_calculation

    attr_accessor :number_invoice_on_add

    attr_accessor :commission_distribution_method

    attr_accessor :commission_distribution_source

    attr_accessor :quote_item_invoice_method


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
        :'job_product_invoice_line_description' => :'jobProductInvoiceLineDescription',
        :'job_invoice_line_description' => :'jobInvoiceLineDescription',
        :'job_part_invoice_line_description' => :'jobPartInvoiceLineDescription',
        :'job_part_item_invoice_line_description' => :'jobPartItemInvoiceLineDescription',
        :'job_material_invoice_line_description' => :'jobMaterialInvoiceLineDescription',
        :'routing_template' => :'routingTemplate',
        :'use_manufacturing_location_prefix' => :'useManufacturingLocationPrefix',
        :'auto_close_jobs' => :'autoCloseJobs',
        :'display_deposits' => :'displayDeposits',
        :'invoice_num_is_job_num' => :'invoiceNumIsJobNum',
        :'tax_distribution_source' => :'taxDistributionSource',
        :'separate_tax_distibution_for_rounding' => :'separateTaxDistibutionForRounding',
        :'create_job_part_work_folders' => :'createJobPartWorkFolders',
        :'finish_good_invoice_description' => :'finishGoodInvoiceDescription',
        :'jacket_type' => :'jacketType',
        :'auto_apply_deposits' => :'autoApplyDeposits',
        :'auto_add_product' => :'autoAddProduct',
        :'finished_good_invoice_method' => :'finishedGoodInvoiceMethod',
        :'job_number_sequence' => :'jobNumberSequence',
        :'job_part_item_invoice_description' => :'jobPartItemInvoiceDescription',
        :'create_job_part_folders' => :'createJobPartFolders',
        :'distribute_tax' => :'distributeTax',
        :'auto_enter_overage' => :'autoEnterOverage',
        :'job_number_prefix' => :'jobNumberPrefix',
        :'auto_enter_underage' => :'autoEnterUnderage',
        :'create_mdff_order' => :'createMdffOrder',
        :'display_part_items' => :'displayPartItems',
        :'use_invoice_description_from' => :'useInvoiceDescriptionFrom',
        :'archive_description' => :'archiveDescription',
        :'invoice_level_options' => :'invoiceLevelOptions',
        :'sales_distribution_method' => :'salesDistributionMethod',
        :'consolidate_vat_tax_distributions' => :'consolidateVatTaxDistributions',
        :'tax_distribution_method' => :'taxDistributionMethod',
        :'sales_tax_basis' => :'salesTaxBasis',
        :'line_item_price_options' => :'lineItemPriceOptions',
        :'bill_parts_together_attribute' => :'billPartsTogetherAttribute',
        :'invoice_quantity' => :'invoiceQuantity',
        :'invoice_date_method' => :'invoiceDateMethod',
        :'job_component_ratio_calculation' => :'jobComponentRatioCalculation',
        :'number_invoice_on_add' => :'numberInvoiceOnAdd',
        :'commission_distribution_method' => :'commissionDistributionMethod',
        :'commission_distribution_source' => :'commissionDistributionSource',
        :'quote_item_invoice_method' => :'quoteItemInvoiceMethod'
      }
    end
  end
end
