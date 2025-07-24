module Pace
  class PersistentQueue < Base
    attr_accessor :id

    attr_accessor :time

    attr_accessor :date

    attr_accessor :status

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :pace_connect

    attr_accessor :execution_node

    attr_accessor :manual_retry_attempt

    attr_accessor :auto_retry_attempts_completed

    attr_accessor :auto_retry_attempt

    attr_accessor :last_attempted_date

    attr_accessor :last_attempted_time

    attr_accessor :ref_id

    attr_accessor :original_pace_connect_result

    attr_accessor :direction

    attr_accessor :failed_reason


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'time' => :'time',
        :'date' => :'date',
        :'status' => :'status',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'pace_connect' => :'paceConnect',
        :'execution_node' => :'executionNode',
        :'manual_retry_attempt' => :'manualRetryAttempt',
        :'auto_retry_attempts_completed' => :'autoRetryAttemptsCompleted',
        :'auto_retry_attempt' => :'autoRetryAttempt',
        :'last_attempted_date' => :'lastAttemptedDate',
        :'last_attempted_time' => :'lastAttemptedTime',
        :'ref_id' => :'refId',
        :'original_pace_connect_result' => :'originalPaceConnectResult',
        :'direction' => :'direction',
        :'failed_reason' => :'failedReason'
      }
    end
  end
end
