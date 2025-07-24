module Pace
  class Option < Base
    attr_accessor :key

    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :setup_time

    attr_accessor :option_list

    attr_accessor :quantity_per_unit

    attr_accessor :speed_adjustment

    attr_accessor :system_generated

    attr_accessor :sequence

    attr_accessor :make_ready_spoilage

    attr_accessor :run_spoilage


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'key' => :'key',
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'setup_time' => :'setupTime',
        :'option_list' => :'optionList',
        :'quantity_per_unit' => :'quantityPerUnit',
        :'speed_adjustment' => :'speedAdjustment',
        :'system_generated' => :'systemGenerated',
        :'sequence' => :'sequence',
        :'make_ready_spoilage' => :'makeReadySpoilage',
        :'run_spoilage' => :'runSpoilage'
      }
    end
  end
end
