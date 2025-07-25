module Pace
  class CRMSetup < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :map_site_url

    attr_accessor :default_activity_type

    attr_accessor :estimate_opportunity_sales_stage

    attr_accessor :estimate_activity_type

    attr_accessor :contact_map_site_url

    attr_accessor :default_opportunity_type

    attr_accessor :default_source_type

    attr_accessor :close_activity_status

    attr_accessor :default_campaign_type

    attr_accessor :default_sales_stage

    attr_accessor :default_activity_status

    attr_accessor :default_campaign_status


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'map_site_url' => :'mapSiteURL',
        :'default_activity_type' => :'defaultActivityType',
        :'estimate_opportunity_sales_stage' => :'estimateOpportunitySalesStage',
        :'estimate_activity_type' => :'estimateActivityType',
        :'contact_map_site_url' => :'contactMapSiteURL',
        :'default_opportunity_type' => :'defaultOpportunityType',
        :'default_source_type' => :'defaultSourceType',
        :'close_activity_status' => :'closeActivityStatus',
        :'default_campaign_type' => :'defaultCampaignType',
        :'default_sales_stage' => :'defaultSalesStage',
        :'default_activity_status' => :'defaultActivityStatus',
        :'default_campaign_status' => :'defaultCampaignStatus'
      }
    end
  end
end
