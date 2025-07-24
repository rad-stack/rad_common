module Pace
  class Activity < Base
    attr_accessor :priority

    attr_accessor :id

    attr_accessor :result

    attr_accessor :hours

    attr_accessor :description

    attr_accessor :status

    attr_accessor :contact

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :entered_by

    attr_accessor :customer

    attr_accessor :estimate

    attr_accessor :assigned_to

    attr_accessor :estimate_request

    attr_accessor :due_date_time

    attr_accessor :quote_number

    attr_accessor :campaign

    attr_accessor :mins

    attr_accessor :issue

    attr_accessor :reminder

    attr_accessor :entered_date_time

    attr_accessor :opportunity

    attr_accessor :activity_date_time

    attr_accessor :short_description

    attr_accessor :activity_type


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'priority' => :'priority',
        :'id' => :'id',
        :'result' => :'result',
        :'hours' => :'hours',
        :'description' => :'description',
        :'status' => :'status',
        :'contact' => :'contact',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'entered_by' => :'enteredBy',
        :'customer' => :'customer',
        :'estimate' => :'estimate',
        :'assigned_to' => :'assignedTo',
        :'estimate_request' => :'estimateRequest',
        :'due_date_time' => :'dueDateTime',
        :'quote_number' => :'quoteNumber',
        :'campaign' => :'campaign',
        :'mins' => :'mins',
        :'issue' => :'issue',
        :'reminder' => :'reminder',
        :'entered_date_time' => :'enteredDateTime',
        :'opportunity' => :'opportunity',
        :'activity_date_time' => :'activityDateTime',
        :'short_description' => :'shortDescription',
        :'activity_type' => :'activityType'
      }
    end
  end
end
