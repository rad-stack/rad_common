module Pace
  class UserDefinedInquiry < Base
    attr_accessor :_module

    attr_accessor :id

    attr_accessor :description

    attr_accessor :group

    attr_accessor :visible

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :base_object

    attr_accessor :show_on_context_menu

    attr_accessor :show_in_dc

    attr_accessor :show_on_dashboard

    attr_accessor :out_of_sync_with_workbench

    attr_accessor :user_defined_form

    attr_accessor :default_email_template

    attr_accessor :inquiry_type

    attr_accessor :last_accessed_date

    attr_accessor :allow_edit_to_others

    attr_accessor :on_workbench

    attr_accessor :internal_only

    attr_accessor :created_date

    attr_accessor :created_by

    attr_accessor :user


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'_module' => :'module',
        :'id' => :'id',
        :'description' => :'description',
        :'group' => :'group',
        :'visible' => :'visible',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'category' => :'category',
        :'base_object' => :'baseObject',
        :'show_on_context_menu' => :'showOnContextMenu',
        :'show_in_dc' => :'showInDC',
        :'show_on_dashboard' => :'showOnDashboard',
        :'out_of_sync_with_workbench' => :'outOfSyncWithWorkbench',
        :'user_defined_form' => :'userDefinedForm',
        :'default_email_template' => :'defaultEmailTemplate',
        :'inquiry_type' => :'inquiryType',
        :'last_accessed_date' => :'lastAccessedDate',
        :'allow_edit_to_others' => :'allowEditToOthers',
        :'on_workbench' => :'onWorkbench',
        :'internal_only' => :'internalOnly',
        :'created_date' => :'createdDate',
        :'created_by' => :'createdBy',
        :'user' => :'user'
      }
    end
  end
end
