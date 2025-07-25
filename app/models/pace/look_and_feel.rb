module Pace
  class LookAndFeel < Base
    attr_accessor :name

    attr_accessor :key

    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :style_sheet

    attr_accessor :welcome_message

    attr_accessor :sidebar_background_color

    attr_accessor :sidebar_background_color_enabled

    attr_accessor :menu_button_text


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'key' => :'key',
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'style_sheet' => :'styleSheet',
        :'welcome_message' => :'welcomeMessage',
        :'sidebar_background_color' => :'sidebarBackgroundColor',
        :'sidebar_background_color_enabled' => :'sidebarBackgroundColorEnabled',
        :'menu_button_text' => :'menuButtonText'
      }
    end
  end
end
