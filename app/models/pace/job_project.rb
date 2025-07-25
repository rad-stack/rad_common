module Pace
  class JobProject < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :code

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :customer

    attr_accessor :due_date

    attr_accessor :default_sales_person

    attr_accessor :default_ship_to_contact


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'code' => :'code',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'customer' => :'customer',
        :'due_date' => :'dueDate',
        :'default_sales_person' => :'defaultSalesPerson',
        :'default_ship_to_contact' => :'defaultShipToContact'
      }
    end
  end
end
