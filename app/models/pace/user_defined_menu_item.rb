module Pace
  class UserDefinedMenuItem < Base
    attr_accessor :id

    attr_accessor :type

    attr_accessor :object

    attr_accessor :active

    attr_accessor :invalid

    attr_accessor :item

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :report_package

    attr_accessor :report

    attr_accessor :prev_sibling_identifier

    attr_accessor :menu_icon

    attr_accessor :user_defined_menu

    attr_accessor :tooltip

    attr_accessor :caption

    attr_accessor :parent_identifier

    attr_accessor :copied_from

    attr_accessor :std_item_identifier

    attr_accessor :enable

    attr_accessor :external_url

    attr_accessor :process

    attr_accessor :invalid_message

    attr_accessor :setup


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'type' => :'type',
        :'object' => :'object',
        :'active' => :'active',
        :'invalid' => :'invalid',
        :'item' => :'item',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'report_package' => :'reportPackage',
        :'report' => :'report',
        :'prev_sibling_identifier' => :'prevSiblingIdentifier',
        :'menu_icon' => :'menuIcon',
        :'user_defined_menu' => :'userDefinedMenu',
        :'tooltip' => :'tooltip',
        :'caption' => :'caption',
        :'parent_identifier' => :'parentIdentifier',
        :'copied_from' => :'copiedFrom',
        :'std_item_identifier' => :'stdItemIdentifier',
        :'enable' => :'enable',
        :'external_url' => :'externalURL',
        :'process' => :'process',
        :'invalid_message' => :'invalidMessage',
        :'setup' => :'setup'
      }
    end
  end
end
