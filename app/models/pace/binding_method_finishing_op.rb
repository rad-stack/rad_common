module Pace
  class BindingMethodFinishingOp < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :finishing_operation

    attr_accessor :operation_level

    attr_accessor :binding_method

    attr_accessor :prompt_option


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'finishing_operation' => :'finishingOperation',
        :'operation_level' => :'operationLevel',
        :'binding_method' => :'bindingMethod',
        :'prompt_option' => :'promptOption'
      }
    end
  end
end
