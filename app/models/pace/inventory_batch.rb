module Pace
  class InventoryBatch < Base
    attr_accessor :id

    attr_accessor :date

    attr_accessor :description

    attr_accessor :status

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :manufacturing_location

    attr_accessor :manual

    attr_accessor :entered_by

    attr_accessor :gl_register_number

    attr_accessor :posted

    attr_accessor :posted_date

    attr_accessor :approved

    attr_accessor :reversal

    attr_accessor :gl_accounting_period

    attr_accessor :posting_status

    attr_accessor :approved_by

    attr_accessor :posting_method

    attr_accessor :original_batch_id

    attr_accessor :inventory_conversion

    attr_accessor :needs_attention

    attr_accessor :auto_added


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'date' => :'date',
        :'description' => :'description',
        :'status' => :'status',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'manufacturing_location' => :'manufacturingLocation',
        :'manual' => :'manual',
        :'entered_by' => :'enteredBy',
        :'gl_register_number' => :'glRegisterNumber',
        :'posted' => :'posted',
        :'posted_date' => :'postedDate',
        :'approved' => :'approved',
        :'reversal' => :'reversal',
        :'gl_accounting_period' => :'glAccountingPeriod',
        :'posting_status' => :'postingStatus',
        :'approved_by' => :'approvedBy',
        :'posting_method' => :'postingMethod',
        :'original_batch_id' => :'originalBatchId',
        :'inventory_conversion' => :'inventoryConversion',
        :'needs_attention' => :'needsAttention',
        :'auto_added' => :'autoAdded'
      }
    end
  end
end
