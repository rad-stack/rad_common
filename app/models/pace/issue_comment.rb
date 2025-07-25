module Pace
  class IssueComment < Base
    attr_accessor :description

    attr_accessor :user_name

    attr_accessor :entry_user

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :entry_date

    attr_accessor :entry_time

    attr_accessor :issue

    attr_accessor :issue_comment_id


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'description' => :'description',
        :'user_name' => :'userName',
        :'entry_user' => :'entryUser',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'entry_date' => :'entryDate',
        :'entry_time' => :'entryTime',
        :'issue' => :'issue',
        :'issue_comment_id' => :'issueCommentId'
      }
    end
  end
end
