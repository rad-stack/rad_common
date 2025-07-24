module Pace
  class NonChargeableType < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :plant_manager_id

    attr_accessor :cost_center

    attr_accessor :ask_note

    attr_accessor :ask_cost_center

    attr_accessor :plant_manager_report_category

    attr_accessor :paid

    attr_accessor :plant_manager_dmi_category


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
        :'plant_manager_id' => :'plantManagerId',
        :'cost_center' => :'costCenter',
        :'ask_note' => :'askNote',
        :'ask_cost_center' => :'askCostCenter',
        :'plant_manager_report_category' => :'plantManagerReportCategory',
        :'paid' => :'paid',
        :'plant_manager_dmi_category' => :'plantManagerDMICategory'
      }
    end
  end
end
