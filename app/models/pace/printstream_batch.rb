module Pace
  class PrintstreamBatch < Base
    attr_accessor :id

    attr_accessor :status

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job

    attr_accessor :order_creation_time

    attr_accessor :parts_skipped_count

    attr_accessor :printstram_id

    attr_accessor :order_creation_date

    attr_accessor :batch_count


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'status' => :'status',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job' => :'job',
        :'order_creation_time' => :'orderCreationTime',
        :'parts_skipped_count' => :'partsSkippedCount',
        :'printstram_id' => :'printstramId',
        :'order_creation_date' => :'orderCreationDate',
        :'batch_count' => :'batchCount'
      }
    end
  end
end
