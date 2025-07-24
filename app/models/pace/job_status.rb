module Pace
  class JobStatus < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :editable

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :production

    attr_accessor :fiery_central_state

    attr_accessor :status_type

    attr_accessor :in_transit

    attr_accessor :billing_ok

    attr_accessor :dsf_completed

    attr_accessor :dsf_cancelled

    attr_accessor :ask_reason

    attr_accessor :open_job

    attr_accessor :ready_for_device_submission

    attr_accessor :dsf_order_status

    attr_accessor :post_actual_costs_from_estimate

    attr_accessor :pageflex_complete

    attr_accessor :ok_to_fc_make_ready_export

    attr_accessor :update_job_version

    attr_accessor :external_status

    attr_accessor :auto_changable

    attr_accessor :ask_comments

    attr_accessor :impose_ok

    attr_accessor :printable_cancelled

    attr_accessor :job_charges_ok

    attr_accessor :admin_to_production

    attr_accessor :admin

    attr_accessor :in_production

    attr_accessor :auto_count_ok

    attr_accessor :sched_ok


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'editable' => :'editable',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'production' => :'production',
        :'fiery_central_state' => :'fieryCentralState',
        :'status_type' => :'statusType',
        :'in_transit' => :'inTransit',
        :'billing_ok' => :'billingOK',
        :'dsf_completed' => :'dsfCompleted',
        :'dsf_cancelled' => :'dsfCancelled',
        :'ask_reason' => :'askReason',
        :'open_job' => :'openJob',
        :'ready_for_device_submission' => :'readyForDeviceSubmission',
        :'dsf_order_status' => :'dsfOrderStatus',
        :'post_actual_costs_from_estimate' => :'postActualCostsFromEstimate',
        :'pageflex_complete' => :'pageflexComplete',
        :'ok_to_fc_make_ready_export' => :'okToFCMakeReadyExport',
        :'update_job_version' => :'updateJobVersion',
        :'external_status' => :'externalStatus',
        :'auto_changable' => :'autoChangable',
        :'ask_comments' => :'askComments',
        :'impose_ok' => :'imposeOK',
        :'printable_cancelled' => :'printableCancelled',
        :'job_charges_ok' => :'jobChargesOK',
        :'admin_to_production' => :'adminToProduction',
        :'admin' => :'admin',
        :'in_production' => :'inProduction',
        :'auto_count_ok' => :'autoCountOK',
        :'sched_ok' => :'schedOK'
      }
    end
  end
end
