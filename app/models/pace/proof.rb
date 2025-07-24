module Pace
  class Proof < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :comments

    attr_accessor :contact

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :qty_shipped

    attr_accessor :request_changes

    attr_accessor :approval_status

    attr_accessor :approver

    attr_accessor :proof_status

    attr_accessor :content_file_location_link

    attr_accessor :requested_by

    attr_accessor :approve

    attr_accessor :reject


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'comments' => :'comments',
        :'contact' => :'contact',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'qty_shipped' => :'qtyShipped',
        :'request_changes' => :'requestChanges',
        :'approval_status' => :'approvalStatus',
        :'approver' => :'approver',
        :'proof_status' => :'proofStatus',
        :'content_file_location_link' => :'contentFileLocationLink',
        :'requested_by' => :'requestedBy',
        :'approve' => :'approve',
        :'reject' => :'reject'
      }
    end
  end
end
