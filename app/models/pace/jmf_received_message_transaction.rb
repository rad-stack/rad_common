module Pace
  class JMFReceivedMessageTransaction < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_transaction

    attr_accessor :audit_entry_status

    attr_accessor :audit_entry_type

    attr_accessor :jmf_received_message

    attr_accessor :transaction_amount

    attr_accessor :audit_entry_id

    attr_accessor :inventory_trn


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_transaction' => :'jobTransaction',
        :'audit_entry_status' => :'auditEntryStatus',
        :'audit_entry_type' => :'auditEntryType',
        :'jmf_received_message' => :'jmfReceivedMessage',
        :'transaction_amount' => :'transactionAmount',
        :'audit_entry_id' => :'auditEntryId',
        :'inventory_trn' => :'inventoryTrn'
      }
    end
  end
end
