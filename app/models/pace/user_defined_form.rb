module Pace
  class UserDefinedForm < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :active

    attr_accessor :contents

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :created_by

    attr_accessor :webapp

    attr_accessor :date_created

    attr_accessor :duplicator

    attr_accessor :plugin_id

    attr_accessor :data_extractor

    attr_accessor :overriden_standard_form

    attr_accessor :deleter

    attr_accessor :user_defined_inquiry

    attr_accessor :popup_width

    attr_accessor :add

    attr_accessor :popup_height

    attr_accessor :popup_full_screen

    attr_accessor :popup

    attr_accessor :transaction_timeout

    attr_accessor :validation_results_handler


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'active' => :'active',
        :'contents' => :'contents',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'created_by' => :'createdBy',
        :'webapp' => :'webapp',
        :'date_created' => :'dateCreated',
        :'duplicator' => :'duplicator',
        :'plugin_id' => :'pluginId',
        :'data_extractor' => :'dataExtractor',
        :'overriden_standard_form' => :'overridenStandardForm',
        :'deleter' => :'deleter',
        :'user_defined_inquiry' => :'userDefinedInquiry',
        :'popup_width' => :'popupWidth',
        :'add' => :'add',
        :'popup_height' => :'popupHeight',
        :'popup_full_screen' => :'popupFullScreen',
        :'popup' => :'popup',
        :'transaction_timeout' => :'transactionTimeout',
        :'validation_results_handler' => :'validationResultsHandler'
      }
    end
  end
end
