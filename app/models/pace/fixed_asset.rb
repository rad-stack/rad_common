module Pace
  class FixedAsset < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :model

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :gl_department

    attr_accessor :template_line

    attr_accessor :gl_location

    attr_accessor :date_setup

    attr_accessor :cost_center

    attr_accessor :note

    attr_accessor :used

    attr_accessor :useful_life_book

    attr_accessor :useful_life_tax

    attr_accessor :asset_posting_group

    attr_accessor :aquisition_date

    attr_accessor :manufacturer

    attr_accessor :block

    attr_accessor :accumulated_depreciation_gl

    attr_accessor :book_value

    attr_accessor :class_code

    attr_accessor :serial_number

    attr_accessor :custodian

    attr_accessor :depreciation_method_book

    attr_accessor :accumulated_dep_tax

    attr_accessor :asset_gl

    attr_accessor :vendor_id

    attr_accessor :depreciation_expense_gl

    attr_accessor :accumulated_dep_book

    attr_accessor :financed

    attr_accessor :tag_number

    attr_accessor :assigned_location

    attr_accessor :linked_asset

    attr_accessor :tax_value

    attr_accessor :loan_description

    attr_accessor :salvage_value

    attr_accessor :cost_basis

    attr_accessor :disposal_date_tax

    attr_accessor :depreciation_method_tax

    attr_accessor :loan_gl_account


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'model' => :'model',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'gl_department' => :'glDepartment',
        :'template_line' => :'templateLine',
        :'gl_location' => :'glLocation',
        :'date_setup' => :'dateSetup',
        :'cost_center' => :'costCenter',
        :'note' => :'note',
        :'used' => :'used',
        :'useful_life_book' => :'usefulLifeBook',
        :'useful_life_tax' => :'usefulLifeTax',
        :'asset_posting_group' => :'assetPostingGroup',
        :'aquisition_date' => :'aquisitionDate',
        :'manufacturer' => :'manufacturer',
        :'block' => :'block',
        :'accumulated_depreciation_gl' => :'accumulatedDepreciationGL',
        :'book_value' => :'bookValue',
        :'class_code' => :'classCode',
        :'serial_number' => :'serialNumber',
        :'custodian' => :'custodian',
        :'depreciation_method_book' => :'depreciationMethodBook',
        :'accumulated_dep_tax' => :'accumulatedDepTax',
        :'asset_gl' => :'assetGL',
        :'vendor_id' => :'vendorID',
        :'depreciation_expense_gl' => :'depreciationExpenseGL',
        :'accumulated_dep_book' => :'accumulatedDepBook',
        :'financed' => :'financed',
        :'tag_number' => :'tagNumber',
        :'assigned_location' => :'assignedLocation',
        :'linked_asset' => :'linkedAsset',
        :'tax_value' => :'taxValue',
        :'loan_description' => :'loanDescription',
        :'salvage_value' => :'salvageValue',
        :'cost_basis' => :'costBasis',
        :'disposal_date_tax' => :'disposalDateTax',
        :'depreciation_method_tax' => :'depreciationMethodTax',
        :'loan_gl_account' => :'loanGLAccount'
      }
    end
  end
end
