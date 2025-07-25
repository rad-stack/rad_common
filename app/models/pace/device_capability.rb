module Pace
  class DeviceCapability < Base
    attr_accessor :name

    attr_accessor :value

    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :dev_cap_name

    attr_accessor :jdf_name


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'value' => :'value',
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'dev_cap_name' => :'devCapName',
        :'jdf_name' => :'jdfName'
      }
    end
  end
end
