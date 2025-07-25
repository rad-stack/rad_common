module Pace
  class PrintstreamLot < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_shipment

    attr_accessor :vendor_lot_no

    attr_accessor :lot_expiration_date

    attr_accessor :lot_job_sell_price_per1000

    attr_accessor :print_stream_pull_ticket_id

    attr_accessor :lot_job_cost_price_per1000

    attr_accessor :detail_id

    attr_accessor :lot_qty


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_shipment' => :'jobShipment',
        :'vendor_lot_no' => :'vendorLotNo',
        :'lot_expiration_date' => :'lotExpirationDate',
        :'lot_job_sell_price_per1000' => :'lotJobSellPricePer1000',
        :'print_stream_pull_ticket_id' => :'printStreamPullTicketID',
        :'lot_job_cost_price_per1000' => :'lotJobCostPricePer1000',
        :'detail_id' => :'detailID',
        :'lot_qty' => :'lotQty'
      }
    end
  end
end
