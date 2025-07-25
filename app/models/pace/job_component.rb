module Pace
  class JobComponent < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :versions

    attr_accessor :qty_to_mfg

    attr_accessor :contact

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job_part_key

    attr_accessor :estimate_source

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :ship_via

    attr_accessor :allowable_overs

    attr_accessor :terms

    attr_accessor :ship_in_name_of

    attr_accessor :ship_to_contact

    attr_accessor :item_template

    attr_accessor :final_size_w

    attr_accessor :colors_s2

    attr_accessor :colors_s1

    attr_accessor :final_size_w_display_uom

    attr_accessor :final_size_h

    attr_accessor :num_sigs

    attr_accessor :final_size_h_display_uom

    attr_accessor :colors_total

    attr_accessor :qty_ordered

    attr_accessor :qty_shipped

    attr_accessor :quantity_remaining

    attr_accessor :printable_order_detail_id

    attr_accessor :job_contact

    attr_accessor :freight_amt

    attr_accessor :production_status

    attr_accessor :actual_ship_date

    attr_accessor :promise_date

    attr_accessor :scheduled_ship_date


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'versions' => :'versions',
        :'qty_to_mfg' => :'qtyToMfg',
        :'contact' => :'contact',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job_part_key' => :'jobPartKey',
        :'estimate_source' => :'estimateSource',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'ship_via' => :'shipVia',
        :'allowable_overs' => :'allowableOvers',
        :'terms' => :'terms',
        :'ship_in_name_of' => :'shipInNameOf',
        :'ship_to_contact' => :'shipToContact',
        :'item_template' => :'itemTemplate',
        :'final_size_w' => :'finalSizeW',
        :'colors_s2' => :'colorsS2',
        :'colors_s1' => :'colorsS1',
        :'final_size_w_display_uom' => :'finalSizeWDisplayUOM',
        :'final_size_h' => :'finalSizeH',
        :'num_sigs' => :'numSigs',
        :'final_size_h_display_uom' => :'finalSizeHDisplayUOM',
        :'colors_total' => :'colorsTotal',
        :'qty_ordered' => :'qtyOrdered',
        :'qty_shipped' => :'qtyShipped',
        :'quantity_remaining' => :'quantityRemaining',
        :'printable_order_detail_id' => :'printableOrderDetailID',
        :'job_contact' => :'jobContact',
        :'freight_amt' => :'freightAmt',
        :'production_status' => :'productionStatus',
        :'actual_ship_date' => :'actualShipDate',
        :'promise_date' => :'promiseDate',
        :'scheduled_ship_date' => :'scheduledShipDate'
      }
    end
  end
end
