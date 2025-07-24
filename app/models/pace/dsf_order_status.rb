module Pace
  class DSFOrderStatus < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :dsf_status

    attr_accessor :dsf_buyer_status

    attr_accessor :send_tracking_information

    attr_accessor :job_status_update

    attr_accessor :order_status_update


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'dsf_status' => :'dsfStatus',
        :'dsf_buyer_status' => :'dsfBuyerStatus',
        :'send_tracking_information' => :'sendTrackingInformation',
        :'job_status_update' => :'jobStatusUpdate',
        :'order_status_update' => :'orderStatusUpdate'
      }
    end
  end
end
