module Pace
  class JobOver < Base
    attr_accessor :id

    attr_accessor :percent

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :customer_group

    attr_accessor :quantity

    attr_accessor :max_units

    attr_accessor :alternate_quantity

    attr_accessor :alternate_percent


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'percent' => :'percent',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'customer_group' => :'customerGroup',
        :'quantity' => :'quantity',
        :'max_units' => :'maxUnits',
        :'alternate_quantity' => :'alternateQuantity',
        :'alternate_percent' => :'alternatePercent'
      }
    end
  end
end
