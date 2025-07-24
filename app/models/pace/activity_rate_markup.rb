module Pace
  class ActivityRateMarkup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :markup_percent

    attr_accessor :up_to_cost

    attr_accessor :activity_rate


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'markup_percent' => :'markupPercent',
        :'up_to_cost' => :'upToCost',
        :'activity_rate' => :'activityRate'
      }
    end
  end
end
