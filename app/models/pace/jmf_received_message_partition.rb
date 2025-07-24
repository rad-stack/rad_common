module Pace
  class JMFReceivedMessagePartition < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :jmf_received_message

    attr_accessor :partition_name

    attr_accessor :partition_value


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'jmf_received_message' => :'jmfReceivedMessage',
        :'partition_name' => :'partitionName',
        :'partition_value' => :'partitionValue'
      }
    end
  end
end
