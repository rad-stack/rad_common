module Pace
  class ScheduledTaskOutputLocation < Base
    attr_accessor :id

    attr_accessor :type

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :primary_key

    attr_accessor :system_generated

    attr_accessor :network_location

    attr_accessor :start_date

    attr_accessor :email_template

    attr_accessor :send_to_all

    attr_accessor :scheduled_task

    attr_accessor :printer_select_type

    attr_accessor :save_sent_email

    attr_accessor :printer_expression

    attr_accessor :email_priority

    attr_accessor :overwrite_files_in_output_location

    attr_accessor :requires_acknowledgment

    attr_accessor :result_condition

    attr_accessor :expiration_date


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'type' => :'type',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'primary_key' => :'primaryKey',
        :'system_generated' => :'systemGenerated',
        :'network_location' => :'networkLocation',
        :'start_date' => :'startDate',
        :'email_template' => :'emailTemplate',
        :'send_to_all' => :'sendToAll',
        :'scheduled_task' => :'scheduledTask',
        :'printer_select_type' => :'printerSelectType',
        :'save_sent_email' => :'saveSentEmail',
        :'printer_expression' => :'printerExpression',
        :'email_priority' => :'emailPriority',
        :'overwrite_files_in_output_location' => :'overwriteFilesInOutputLocation',
        :'requires_acknowledgment' => :'requiresAcknowledgment',
        :'result_condition' => :'resultCondition',
        :'expiration_date' => :'expirationDate'
      }
    end
  end
end
