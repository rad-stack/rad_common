module Pace
  class JMFReceivedMessage < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :received_date_time

    attr_accessor :job_part_id

    attr_accessor :job_id

    attr_accessor :signal_type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'received_date_time' => :'receivedDateTime',
        :'job_part_id' => :'jobPartId',
        :'job_id' => :'jobId',
        :'signal_type' => :'signalType'
      }
    end
  end
end
