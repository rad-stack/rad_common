module Pace
  class Estimator < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :email

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :auto_add_quote_letter

    attr_accessor :display_update_button

    attr_accessor :show_add_add_new_version

    attr_accessor :use_tabs_on_estimate_add_form

    attr_accessor :estimate_printout_preference

    attr_accessor :show_add_add_new_estimate

    attr_accessor :manual_cross_tab_copy

    attr_accessor :show_add_version_on_detail

    attr_accessor :show_calculate_button


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'email' => :'email',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'auto_add_quote_letter' => :'autoAddQuoteLetter',
        :'display_update_button' => :'displayUpdateButton',
        :'show_add_add_new_version' => :'showAddAddNewVersion',
        :'use_tabs_on_estimate_add_form' => :'useTabsOnEstimateAddForm',
        :'estimate_printout_preference' => :'estimatePrintoutPreference',
        :'show_add_add_new_estimate' => :'showAddAddNewEstimate',
        :'manual_cross_tab_copy' => :'manualCrossTabCopy',
        :'show_add_version_on_detail' => :'showAddVersionOnDetail',
        :'show_calculate_button' => :'showCalculateButton'
      }
    end
  end
end
