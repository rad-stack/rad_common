module Pace
  class PaceConnectJMFMessageType < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :pace_connect

    attr_accessor :send_on_automatic_execute

    attr_accessor :message_type

    attr_accessor :message_family


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'pace_connect' => :'paceConnect',
        :'send_on_automatic_execute' => :'sendOnAutomaticExecute',
        :'message_type' => :'messageType',
        :'message_family' => :'messageFamily'
      }
    end
  end
end
