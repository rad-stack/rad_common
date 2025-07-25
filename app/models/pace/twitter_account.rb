module Pace
  class TwitterAccount < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :title

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :pub_date

    attr_accessor :access_token

    attr_accessor :consumer_secret

    attr_accessor :access_key

    attr_accessor :consumer_key


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'title' => :'title',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'pub_date' => :'pubDate',
        :'access_token' => :'accessToken',
        :'consumer_secret' => :'consumerSecret',
        :'access_key' => :'accessKey',
        :'consumer_key' => :'consumerKey'
      }
    end
  end
end
