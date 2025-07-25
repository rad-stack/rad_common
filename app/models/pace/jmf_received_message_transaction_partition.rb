module Pace
  class JMFReceivedMessageTransactionPartition < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :partition_name

    attr_accessor :partition_value

    attr_accessor :jmf_received_message_transaction


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'partition_name' => :'partitionName',
        :'partition_value' => :'partitionValue',
        :'jmf_received_message_transaction' => :'jmfReceivedMessageTransaction'
      }
    end
  end
end
