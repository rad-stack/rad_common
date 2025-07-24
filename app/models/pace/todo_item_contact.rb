module Pace
  class TodoItemContact < Base
    attr_accessor :email_address

    attr_accessor :given_name

    attr_accessor :family_name

    attr_accessor :phone_numbers

    attr_accessor :type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'email_address' => :'emailAddress',
        :'given_name' => :'givenName',
        :'family_name' => :'familyName',
        :'phone_numbers' => :'phoneNumbers',
        :'type' => :'type'
      }
    end
  end
end
