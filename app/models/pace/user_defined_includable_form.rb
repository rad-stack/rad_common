module Pace
  class UserDefinedIncludableForm < Base
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

    attr_accessor :data_extractor

    attr_accessor :overriden_standard_form

    attr_accessor :deleter

    attr_accessor :user_defined_inquiry

    attr_accessor :add

    attr_accessor :transaction_timeout

    attr_accessor :validation_results_handler

    attr_accessor :standard_form


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
        :'data_extractor' => :'dataExtractor',
        :'overriden_standard_form' => :'overridenStandardForm',
        :'deleter' => :'deleter',
        :'user_defined_inquiry' => :'userDefinedInquiry',
        :'add' => :'add',
        :'transaction_timeout' => :'transactionTimeout',
        :'validation_results_handler' => :'validationResultsHandler',
        :'standard_form' => :'standardForm'
      }
    end
  end
end
