module Pace
  class FulfillmentSetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :create_shipment

    attr_accessor :single_carton

    attr_accessor :single_shipment

    attr_accessor :default_customer

    attr_accessor :create_shipment_for_replenishment_jobs

    attr_accessor :default_job_description

    attr_accessor :default_promise_time

    attr_accessor :default_sub_job_type

    attr_accessor :default_fg_shipment_type

    attr_accessor :overide_job_product_description

    attr_accessor :use_actual_qty_shipped

    attr_accessor :default_promise_date

    attr_accessor :auto_pull_inventory

    attr_accessor :pick_ticket_id

    attr_accessor :job_part_description

    attr_accessor :default_shipment_type

    attr_accessor :seperate_replenishment_jobs

    attr_accessor :default_ship_via

    attr_accessor :display_job_entry_screeen

    attr_accessor :default_job_type

    attr_accessor :single_job_part

    attr_accessor :populate_shipment_contacts

    attr_accessor :overide_job_part_description

    attr_accessor :job_product_description

    attr_accessor :replenishment_job_part_location


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'create_shipment' => :'createShipment',
        :'single_carton' => :'singleCarton',
        :'single_shipment' => :'singleShipment',
        :'default_customer' => :'defaultCustomer',
        :'create_shipment_for_replenishment_jobs' => :'createShipmentForReplenishmentJobs',
        :'default_job_description' => :'defaultJobDescription',
        :'default_promise_time' => :'defaultPromiseTime',
        :'default_sub_job_type' => :'defaultSubJobType',
        :'default_fg_shipment_type' => :'defaultFGShipmentType',
        :'overide_job_product_description' => :'overideJobProductDescription',
        :'use_actual_qty_shipped' => :'useActualQtyShipped',
        :'default_promise_date' => :'defaultPromiseDate',
        :'auto_pull_inventory' => :'autoPullInventory',
        :'pick_ticket_id' => :'pickTicketId',
        :'job_part_description' => :'jobPartDescription',
        :'default_shipment_type' => :'defaultShipmentType',
        :'seperate_replenishment_jobs' => :'seperateReplenishmentJobs',
        :'default_ship_via' => :'defaultShipVia',
        :'display_job_entry_screeen' => :'displayJobEntryScreeen',
        :'default_job_type' => :'defaultJobType',
        :'single_job_part' => :'singleJobPart',
        :'populate_shipment_contacts' => :'populateShipmentContacts',
        :'overide_job_part_description' => :'overideJobPartDescription',
        :'job_product_description' => :'jobProductDescription',
        :'replenishment_job_part_location' => :'replenishmentJobPartLocation'
      }
    end
  end
end
