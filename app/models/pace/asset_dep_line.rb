module Pace
  class AssetDepLine < Base
    attr_accessor :id

    attr_accessor :date

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :posted

    attr_accessor :fixed_assetid

    attr_accessor :manual_entry

    attr_accessor :book_depreciation_amount

    attr_accessor :gl_period

    attr_accessor :asset_transaction_id

    attr_accessor :tax_depreciation_amount

    attr_accessor :asset_batch


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'date' => :'date',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'gl_department' => :'glDepartment',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'posted' => :'posted',
        :'fixed_assetid' => :'fixedAssetid',
        :'manual_entry' => :'manualEntry',
        :'book_depreciation_amount' => :'bookDepreciationAmount',
        :'gl_period' => :'glPeriod',
        :'asset_transaction_id' => :'assetTransactionId',
        :'tax_depreciation_amount' => :'taxDepreciationAmount',
        :'asset_batch' => :'assetBatch'
      }
    end
  end
end
