module Pace
  class ItemTemplateSetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :enable_for_manual_job_entry

    attr_accessor :consolidate_item_template_estimates_on_multipart_job

    attr_accessor :auto_print_jacket

    attr_accessor :enable_inventory_pace_connect_execute_buttons


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'enable_for_manual_job_entry' => :'enableForManualJobEntry',
        :'consolidate_item_template_estimates_on_multipart_job' => :'consolidateItemTemplateEstimatesOnMultipartJob',
        :'auto_print_jacket' => :'autoPrintJacket',
        :'enable_inventory_pace_connect_execute_buttons' => :'enableInventoryPaceConnectExecuteButtons'
      }
    end
  end
end
