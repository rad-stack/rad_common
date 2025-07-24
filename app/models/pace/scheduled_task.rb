module Pace
  class ScheduledTask < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :handler

    attr_accessor :reason

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :system_generated

    attr_accessor :pace_connect_generated

    attr_accessor :pace_connect

    attr_accessor :base_object

    attr_accessor :start_date_time

    attr_accessor :email_template

    attr_accessor :email_priority

    attr_accessor :allows_base_object_selection

    attr_accessor :report_package

    attr_accessor :notification_expiration_date

    attr_accessor :system_user

    attr_accessor :handler_name

    attr_accessor :notification_start_date

    attr_accessor :allows_configuration_edits

    attr_accessor :last_execution_id

    attr_accessor :notification_requires_acknowledgment

    attr_accessor :notification_send_to_all

    attr_accessor :last_run_status

    attr_accessor :end_date_time

    attr_accessor :maximum_execution_results_to_store

    attr_accessor :records_to_post

    attr_accessor :last_run_date_time

    attr_accessor :xpath_filter

    attr_accessor :report


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'handler' => :'handler',
        :'reason' => :'reason',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'system_generated' => :'systemGenerated',
        :'pace_connect_generated' => :'paceConnectGenerated',
        :'pace_connect' => :'paceConnect',
        :'base_object' => :'baseObject',
        :'start_date_time' => :'startDateTime',
        :'email_template' => :'emailTemplate',
        :'email_priority' => :'emailPriority',
        :'allows_base_object_selection' => :'allowsBaseObjectSelection',
        :'report_package' => :'reportPackage',
        :'notification_expiration_date' => :'notificationExpirationDate',
        :'system_user' => :'systemUser',
        :'handler_name' => :'handlerName',
        :'notification_start_date' => :'notificationStartDate',
        :'allows_configuration_edits' => :'allowsConfigurationEdits',
        :'last_execution_id' => :'lastExecutionId',
        :'notification_requires_acknowledgment' => :'notificationRequiresAcknowledgment',
        :'notification_send_to_all' => :'notificationSendToAll',
        :'last_run_status' => :'lastRunStatus',
        :'end_date_time' => :'endDateTime',
        :'maximum_execution_results_to_store' => :'maximumExecutionResultsToStore',
        :'records_to_post' => :'recordsToPost',
        :'last_run_date_time' => :'lastRunDateTime',
        :'xpath_filter' => :'xpathFilter',
        :'report' => :'report'
      }
    end
  end
end
