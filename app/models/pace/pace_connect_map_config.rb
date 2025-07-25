module Pace
  class PaceConnectMapConfig < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :finishing_operation

    attr_accessor :pace_connect

    attr_accessor :xpath_condition

    attr_accessor :config_type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'finishing_operation' => :'finishingOperation',
        :'pace_connect' => :'paceConnect',
        :'xpath_condition' => :'xpathCondition',
        :'config_type' => :'configType'
      }
    end
  end
end
