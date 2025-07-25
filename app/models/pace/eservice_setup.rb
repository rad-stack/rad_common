module Pace
  class EserviceSetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :look_and_feel

    attr_accessor :freight_activity_code

    attr_accessor :default_convert_job_type

    attr_accessor :cancel_admin_status

    attr_accessor :default_convert_job_type_po

    attr_accessor :planned_shipment_type

    attr_accessor :update_admin_status_on_cancel

    attr_accessor :include_message

    attr_accessor :punchout_supplier_id

    attr_accessor :guest_user

    attr_accessor :allways_allow_convert

    attr_accessor :send_error_message

    attr_accessor :minutes_till_error_message

    attr_accessor :job_auto_create_type

    attr_accessor :auto_convert_to_job

    attr_accessor :default_admin_status

    attr_accessor :completed_shopping_cart_message

    attr_accessor :email_notify_estimate_request

    attr_accessor :suppress_freight_email

    attr_accessor :template_user

    attr_accessor :apply_cart_extra_amount

    attr_accessor :punchout_unspsc


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'look_and_feel' => :'lookAndFeel',
        :'freight_activity_code' => :'freightActivityCode',
        :'default_convert_job_type' => :'defaultConvertJobType',
        :'cancel_admin_status' => :'cancelAdminStatus',
        :'default_convert_job_type_po' => :'defaultConvertJobTypePO',
        :'planned_shipment_type' => :'plannedShipmentType',
        :'update_admin_status_on_cancel' => :'updateAdminStatusOnCancel',
        :'include_message' => :'includeMessage',
        :'punchout_supplier_id' => :'punchoutSupplierId',
        :'guest_user' => :'guestUser',
        :'allways_allow_convert' => :'allwaysAllowConvert',
        :'send_error_message' => :'sendErrorMessage',
        :'minutes_till_error_message' => :'minutesTillErrorMessage',
        :'job_auto_create_type' => :'jobAutoCreateType',
        :'auto_convert_to_job' => :'autoConvertToJob',
        :'default_admin_status' => :'defaultAdminStatus',
        :'completed_shopping_cart_message' => :'completedShoppingCartMessage',
        :'email_notify_estimate_request' => :'emailNotifyEstimateRequest',
        :'suppress_freight_email' => :'suppressFreightEmail',
        :'template_user' => :'templateUser',
        :'apply_cart_extra_amount' => :'applyCartExtraAmount',
        :'punchout_unspsc' => :'punchoutUnspsc'
      }
    end
  end
end
