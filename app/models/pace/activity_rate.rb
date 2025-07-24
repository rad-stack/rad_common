module Pace
  class ActivityRate < Base
    attr_accessor :id

    attr_accessor :line_number

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :activity_code

    attr_accessor :total_cost

    attr_accessor :general_oa

    attr_accessor :machine_cost

    attr_accessor :labor_overhead

    attr_accessor :sell_cost

    attr_accessor :cost_markup

    attr_accessor :markup_list

    attr_accessor :labor_cost


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'line_number' => :'lineNumber',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'activity_code' => :'activityCode',
        :'total_cost' => :'totalCost',
        :'general_oa' => :'generalOA',
        :'machine_cost' => :'machineCost',
        :'labor_overhead' => :'laborOverhead',
        :'sell_cost' => :'sellCost',
        :'cost_markup' => :'costMarkup',
        :'markup_list' => :'markupList',
        :'labor_cost' => :'laborCost'
      }
    end
  end
end
