module Pace
  class AssetTransaction < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :date

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :posted

    attr_accessor :amount

    attr_accessor :gl_account

    attr_accessor :invoice

    attr_accessor :asset_transaction_batch

    attr_accessor :book_value

    attr_accessor :vendor_id

    attr_accessor :tax_value

    attr_accessor :salvage_value

    attr_accessor :start_depreciation_date

    attr_accessor :capital_cost_basis

    attr_accessor :impairment_amount

    attr_accessor :impairment_account

    attr_accessor :tran_type

    attr_accessor :accumulated_depreciation_book

    attr_accessor :fixed_assetid

    attr_accessor :to_gl_location

    attr_accessor :disposal_sale_amount

    attr_accessor :accumulated_depreciation_tax

    attr_accessor :disposal_gain_loss_account

    attr_accessor :vendor_name


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'date' => :'date',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'posted' => :'posted',
        :'amount' => :'amount',
        :'gl_account' => :'glAccount',
        :'invoice' => :'invoice',
        :'asset_transaction_batch' => :'assetTransactionBatch',
        :'book_value' => :'bookValue',
        :'vendor_id' => :'vendorID',
        :'tax_value' => :'taxValue',
        :'salvage_value' => :'salvageValue',
        :'start_depreciation_date' => :'startDepreciationDate',
        :'capital_cost_basis' => :'capitalCostBasis',
        :'impairment_amount' => :'impairmentAmount',
        :'impairment_account' => :'impairmentAccount',
        :'tran_type' => :'tranType',
        :'accumulated_depreciation_book' => :'accumulatedDepreciationBook',
        :'fixed_assetid' => :'fixedAssetid',
        :'to_gl_location' => :'toGlLocation',
        :'disposal_sale_amount' => :'disposalSaleAmount',
        :'accumulated_depreciation_tax' => :'accumulatedDepreciationTax',
        :'disposal_gain_loss_account' => :'disposalGainLossAccount',
        :'vendor_name' => :'vendorName'
      }
    end
  end
end
