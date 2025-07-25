module Pace
  class ReportPackageEntry < Base
    attr_accessor :package

    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_generated

    attr_accessor :report

    attr_accessor :export_name_x_path

    attr_accessor :condition

    attr_accessor :unique_only

    attr_accessor :base_object_selection_x_path


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'package' => :'package',
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'system_generated' => :'systemGenerated',
        :'report' => :'report',
        :'export_name_x_path' => :'exportNameXPath',
        :'condition' => :'condition',
        :'unique_only' => :'uniqueOnly',
        :'base_object_selection_x_path' => :'baseObjectSelectionXPath'
      }
    end
  end
end
