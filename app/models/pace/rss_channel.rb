module Pace
  class RSSChannel < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :time_to_live

    attr_accessor :description

    attr_accessor :title

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :link

    attr_accessor :last_build_date

    attr_accessor :managing_editor

    attr_accessor :pub_date

    attr_accessor :web_master


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'time_to_live' => :'timeToLive',
        :'description' => :'description',
        :'title' => :'title',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'category' => :'category',
        :'link' => :'link',
        :'last_build_date' => :'lastBuildDate',
        :'managing_editor' => :'managingEditor',
        :'pub_date' => :'pubDate',
        :'web_master' => :'webMaster'
      }
    end
  end
end
