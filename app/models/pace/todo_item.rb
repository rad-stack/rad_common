module Pace
  class TodoItem < Base
    attr_accessor :reference

    attr_accessor :id

    attr_accessor :type

    attr_accessor :description

    attr_accessor :items

    attr_accessor :notes

    attr_accessor :zip

    attr_accessor :customer

    attr_accessor :date_time

    attr_accessor :address_line1

    attr_accessor :address_line2

    attr_accessor :address_line3

    attr_accessor :contact_position

    attr_accessor :job_number

    attr_accessor :town

    attr_accessor :contact_name


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'reference' => :'reference',
        :'id' => :'id',
        :'type' => :'type',
        :'description' => :'description',
        :'items' => :'items',
        :'notes' => :'notes',
        :'zip' => :'zip',
        :'customer' => :'customer',
        :'date_time' => :'dateTime',
        :'address_line1' => :'addressLine1',
        :'address_line2' => :'addressLine2',
        :'address_line3' => :'addressLine3',
        :'contact_position' => :'contactPosition',
        :'job_number' => :'jobNumber',
        :'town' => :'town',
        :'contact_name' => :'contactName'
      }
    end
  end
end
