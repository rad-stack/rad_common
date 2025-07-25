module Pace
  class Issue < Base
    attr_accessor :id

    attr_accessor :description

    attr_accessor :entry_user

    attr_accessor :activity

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :base_object

    attr_accessor :amount

    attr_accessor :base_object_key

    attr_accessor :additional_description

    attr_accessor :entry_date

    attr_accessor :due_date

    attr_accessor :issue_resolution_details

    attr_accessor :reporter

    attr_accessor :issue_sub_type

    attr_accessor :assigned_to

    attr_accessor :issue_type

    attr_accessor :issue_status

    attr_accessor :entry_time

    attr_accessor :issue_resolution


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'description' => :'description',
        :'entry_user' => :'entryUser',
        :'activity' => :'activity',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'base_object' => :'baseObject',
        :'amount' => :'amount',
        :'base_object_key' => :'baseObjectKey',
        :'additional_description' => :'additionalDescription',
        :'entry_date' => :'entryDate',
        :'due_date' => :'dueDate',
        :'issue_resolution_details' => :'issueResolutionDetails',
        :'reporter' => :'reporter',
        :'issue_sub_type' => :'issueSubType',
        :'assigned_to' => :'assignedTo',
        :'issue_type' => :'issueType',
        :'issue_status' => :'issueStatus',
        :'entry_time' => :'entryTime',
        :'issue_resolution' => :'issueResolution'
      }
    end
  end
end
