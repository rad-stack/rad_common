module Pace
  class PaceConnectResult < Base
    attr_accessor :id

    attr_accessor :type

    attr_accessor :result

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :pace_connect

    attr_accessor :retryable

    attr_accessor :bod_acknowledgement

    attr_accessor :execution_node

    attr_accessor :bod_id

    attr_accessor :execution_date_time

    attr_accessor :bod_error_information

    attr_accessor :retry_mode

    attr_accessor :executed_by

    attr_accessor :original_file_name

    attr_accessor :manual_retry_attempt

    attr_accessor :final_queue_result

    attr_accessor :persistent_queue

    attr_accessor :reference_url

    attr_accessor :topic_name

    attr_accessor :correlation_id

    attr_accessor :retry_attempt

    attr_accessor :retry_location

    attr_accessor :parent_result

    attr_accessor :auto_retry_attempts_completed

    attr_accessor :execution_attempt

    attr_accessor :event


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'type' => :'type',
        :'result' => :'result',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'pace_connect' => :'paceConnect',
        :'retryable' => :'retryable',
        :'bod_acknowledgement' => :'bodAcknowledgement',
        :'execution_node' => :'executionNode',
        :'bod_id' => :'bodID',
        :'execution_date_time' => :'executionDateTime',
        :'bod_error_information' => :'bodErrorInformation',
        :'retry_mode' => :'retryMode',
        :'executed_by' => :'executedBy',
        :'original_file_name' => :'originalFileName',
        :'manual_retry_attempt' => :'manualRetryAttempt',
        :'final_queue_result' => :'finalQueueResult',
        :'persistent_queue' => :'persistentQueue',
        :'reference_url' => :'referenceURL',
        :'topic_name' => :'topicName',
        :'correlation_id' => :'correlationID',
        :'retry_attempt' => :'retryAttempt',
        :'retry_location' => :'retryLocation',
        :'parent_result' => :'parentResult',
        :'auto_retry_attempts_completed' => :'autoRetryAttemptsCompleted',
        :'execution_attempt' => :'executionAttempt',
        :'event' => :'event'
      }
    end
  end
end
