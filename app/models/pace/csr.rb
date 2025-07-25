module Pace
  class CSR < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :password

    attr_accessor :email

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :phone_extension

    attr_accessor :phone_number


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'password' => :'password',
        :'email' => :'email',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'phone_extension' => :'phoneExtension',
        :'phone_number' => :'phoneNumber'
      }
    end
  end
end
