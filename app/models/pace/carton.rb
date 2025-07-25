module Pace
  class Carton < Base
    attr_accessor :id

    attr_accessor :count

    attr_accessor :weight

    attr_accessor :component

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :quantity

    attr_accessor :note

    attr_accessor :cost

    attr_accessor :tracking_number

    attr_accessor :total_quantity

    attr_accessor :shipment

    attr_accessor :skid

    attr_accessor :skid_count

    attr_accessor :tracking_link

    attr_accessor :add_default_content

    attr_accessor :print_stream_package_id

    attr_accessor :actual_date_time

    attr_accessor :print_stream_detail_id

    attr_accessor :received_by

    attr_accessor :total_skid_quantity


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'count' => :'count',
        :'weight' => :'weight',
        :'component' => :'component',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'quantity' => :'quantity',
        :'note' => :'note',
        :'cost' => :'cost',
        :'tracking_number' => :'trackingNumber',
        :'total_quantity' => :'totalQuantity',
        :'shipment' => :'shipment',
        :'skid' => :'skid',
        :'skid_count' => :'skidCount',
        :'tracking_link' => :'trackingLink',
        :'add_default_content' => :'addDefaultContent',
        :'print_stream_package_id' => :'printStreamPackageID',
        :'actual_date_time' => :'actualDateTime',
        :'print_stream_detail_id' => :'printStreamDetailID',
        :'received_by' => :'receivedBy',
        :'total_skid_quantity' => :'totalSkidQuantity'
      }
    end
  end
end
