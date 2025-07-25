module Pace
  class DigitalWorkflowSetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :min_pages_to_split2_up

    attr_accessor :default_cutting_op

    attr_accessor :default_ncr_glue

    attr_accessor :default_color_insert

    attr_accessor :min_orig_per_doc_auto2_up

    attr_accessor :default_stitching_op

    attr_accessor :default_collating_op

    attr_accessor :default_folding_op

    attr_accessor :default_slip_sheet


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'min_pages_to_split2_up' => :'minPagesToSplit2Up',
        :'default_cutting_op' => :'defaultCuttingOp',
        :'default_ncr_glue' => :'defaultNCRGlue',
        :'default_color_insert' => :'defaultColorInsert',
        :'min_orig_per_doc_auto2_up' => :'minOrigPerDocAuto2Up',
        :'default_stitching_op' => :'defaultStitchingOp',
        :'default_collating_op' => :'defaultCollatingOp',
        :'default_folding_op' => :'defaultFoldingOp',
        :'default_slip_sheet' => :'defaultSlipSheet'
      }
    end
  end
end
