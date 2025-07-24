module Pace
  class Company < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :state

    attr_accessor :version

    attr_accessor :major_version

    attr_accessor :country

    attr_accessor :tags

    attr_accessor :notes

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :web_site

    attr_accessor :look_and_feel

    attr_accessor :state_key

    attr_accessor :phone_number

    attr_accessor :price_list

    attr_accessor :zip

    attr_accessor :city

    attr_accessor :credit_card_processing_enabled

    attr_accessor :address3

    attr_accessor :address2

    attr_accessor :address1

    attr_accessor :fax_number

    attr_accessor :sidebar_background_color

    attr_accessor :sidebar_background_color_enabled

    attr_accessor :state_tax_id

    attr_accessor :paper_weight

    attr_accessor :paper_type

    attr_accessor :default_manufacturing_location

    attr_accessor :display_fractions

    attr_accessor :tax_reference1

    attr_accessor :tax_reference2

    attr_accessor :merchant_login

    attr_accessor :max_delete_history_audits

    attr_accessor :email_bank_rec

    attr_accessor :ups_server

    attr_accessor :fed_ex_account_number

    attr_accessor :ldap_port

    attr_accessor :legacy_job_forms

    attr_accessor :auto_login

    attr_accessor :enable_samlsso

    attr_accessor :auto_login_timeout

    attr_accessor :max_selective_duplication_elements

    attr_accessor :email_receivables

    attr_accessor :fed_ex_key

    attr_accessor :display_iso_alpha3

    attr_accessor :memory_physical

    attr_accessor :company_legal_name

    attr_accessor :payment_gateway_url

    attr_accessor :mask_confidential_fields

    attr_accessor :password_expiration_days

    attr_accessor :show_workbench_chat

    attr_accessor :federal_tax_id

    attr_accessor :default_grid_page_size

    attr_accessor :email_estimating

    attr_accessor :memory_minimum_recommended

    attr_accessor :max_import_elements

    attr_accessor :ldap_host

    attr_accessor :map_print_shop_defaults

    attr_accessor :disable_phone_number_format

    attr_accessor :fed_ex_meter_number

    attr_accessor :auto_purge_audits

    attr_accessor :password_minimum_numeric_char

    attr_accessor :duns

    attr_accessor :email_sales

    attr_accessor :fed_ex_password

    attr_accessor :email_production

    attr_accessor :ups_password

    attr_accessor :display_navigator

    attr_accessor :maintenance_mode

    attr_accessor :memory_maximum_recommended

    attr_accessor :legacy_invoice_forms

    attr_accessor :password_minimum_alpha_char_lowercase

    attr_accessor :email_inventory

    attr_accessor :ups_username

    attr_accessor :payment_gateway_name

    attr_accessor :eula_user

    attr_accessor :email_personnel

    attr_accessor :eula_time

    attr_accessor :num_audit_records_per_object

    attr_accessor :use_company_name_for_root_label

    attr_accessor :show_last_login

    attr_accessor :email_technical

    attr_accessor :maintenance_start_time

    attr_accessor :validate_internal_only_emails

    attr_accessor :use_ldap_authentication

    attr_accessor :disable_emailing

    attr_accessor :check_white_listed_attachment_type

    attr_accessor :number_of_required_system_notifications

    attr_accessor :max_import_pace_connects

    attr_accessor :password_minimum_alpha_char_uppercase

    attr_accessor :internal_ip_ranges

    attr_accessor :case_sensitive_search

    attr_accessor :redirect_on_session_timeout

    attr_accessor :payment_gateway_url2

    attr_accessor :send_manual_email_via

    attr_accessor :last_inventory_calc

    attr_accessor :default_save_email_setting

    attr_accessor :prevent_duplicate_contacts

    attr_accessor :metric

    attr_accessor :password_minimum_non_alpha_non_numeric_char

    attr_accessor :max_import_control

    attr_accessor :max_import_template_objects

    attr_accessor :current_organization_company

    attr_accessor :security_enabled

    attr_accessor :email_job_billing

    attr_accessor :eula_accepted

    attr_accessor :max_import_records

    attr_accessor :hide_error_stack_trace

    attr_accessor :email_scheduling

    attr_accessor :email_customer_service

    attr_accessor :auto_logoff_timeout

    attr_accessor :point_release_version

    attr_accessor :disable_customizations

    attr_accessor :max_days_audits

    attr_accessor :alternate_text

    attr_accessor :default_ldap_group

    attr_accessor :password_previous_to_check

    attr_accessor :disk_space_warning

    attr_accessor :transaction_key

    attr_accessor :try_to_prevent_browser_using_saved_passwords

    attr_accessor :eula_date

    attr_accessor :search_wrapping_wildcards

    attr_accessor :fed_ex_server

    attr_accessor :allow_duplicate_job_contacts

    attr_accessor :new_version_available

    attr_accessor :theme_location

    attr_accessor :email_purchasing

    attr_accessor :disable_parallel_grid_data_fetch

    attr_accessor :password_minimum_length

    attr_accessor :maintenance_end_time

    attr_accessor :md5_value

    attr_accessor :email_accounting

    attr_accessor :max_import_parameter

    attr_accessor :breadcrumb_root_label

    attr_accessor :old_size_denominator

    attr_accessor :ups_access_code

    attr_accessor :email_system_admin

    attr_accessor :ldap_realm

    attr_accessor :base_currency

    attr_accessor :password_failures_before_lockout

    attr_accessor :disable_auto_login

    attr_accessor :use_secure_id_in_url

    attr_accessor :report_analytical_data

    attr_accessor :upgrade_mode

    attr_accessor :max_import_template_x_path_variables

    attr_accessor :duplicate_content_file_with_estimate_and_job

    attr_accessor :max_import_control_x_path

    attr_accessor :email_gl

    attr_accessor :sso_service_provider_url

    attr_accessor :show_workbench_dashboard

    attr_accessor :size_denominator

    attr_accessor :maximum_dropdown_limit

    attr_accessor :alt_phone_number

    attr_accessor :max_import_templates

    attr_accessor :number_of_system_notifications

    attr_accessor :form_session_expiration_time

    attr_accessor :send_order_confirmation_message

    attr_accessor :email_payables

    attr_accessor :maximum_continuations_per_user

    attr_accessor :edi_user


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'state' => :'state',
        :'version' => :'version',
        :'major_version' => :'majorVersion',
        :'country' => :'country',
        :'tags' => :'tags',
        :'notes' => :'notes',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'web_site' => :'webSite',
        :'look_and_feel' => :'lookAndFeel',
        :'state_key' => :'stateKey',
        :'phone_number' => :'phoneNumber',
        :'price_list' => :'priceList',
        :'zip' => :'zip',
        :'city' => :'city',
        :'credit_card_processing_enabled' => :'creditCardProcessingEnabled',
        :'address3' => :'address3',
        :'address2' => :'address2',
        :'address1' => :'address1',
        :'fax_number' => :'faxNumber',
        :'sidebar_background_color' => :'sidebarBackgroundColor',
        :'sidebar_background_color_enabled' => :'sidebarBackgroundColorEnabled',
        :'state_tax_id' => :'stateTaxID',
        :'paper_weight' => :'paperWeight',
        :'paper_type' => :'paperType',
        :'default_manufacturing_location' => :'defaultManufacturingLocation',
        :'display_fractions' => :'displayFractions',
        :'tax_reference1' => :'taxReference1',
        :'tax_reference2' => :'taxReference2',
        :'merchant_login' => :'merchantLogin',
        :'max_delete_history_audits' => :'maxDeleteHistoryAudits',
        :'email_bank_rec' => :'emailBankRec',
        :'ups_server' => :'upsServer',
        :'fed_ex_account_number' => :'fedExAccountNumber',
        :'ldap_port' => :'ldapPort',
        :'legacy_job_forms' => :'legacyJobForms',
        :'auto_login' => :'autoLogin',
        :'enable_samlsso' => :'enableSAMLSSO',
        :'auto_login_timeout' => :'autoLoginTimeout',
        :'max_selective_duplication_elements' => :'maxSelectiveDuplicationElements',
        :'email_receivables' => :'emailReceivables',
        :'fed_ex_key' => :'fedExKey',
        :'display_iso_alpha3' => :'displayIsoAlpha3',
        :'memory_physical' => :'memoryPhysical',
        :'company_legal_name' => :'companyLegalName',
        :'payment_gateway_url' => :'paymentGatewayURL',
        :'mask_confidential_fields' => :'maskConfidentialFields',
        :'password_expiration_days' => :'passwordExpirationDays',
        :'show_workbench_chat' => :'showWorkbenchChat',
        :'federal_tax_id' => :'federalTaxID',
        :'default_grid_page_size' => :'defaultGridPageSize',
        :'email_estimating' => :'emailEstimating',
        :'memory_minimum_recommended' => :'memoryMinimumRecommended',
        :'max_import_elements' => :'maxImportElements',
        :'ldap_host' => :'ldapHost',
        :'map_print_shop_defaults' => :'mapPrintShopDefaults',
        :'disable_phone_number_format' => :'disablePhoneNumberFormat',
        :'fed_ex_meter_number' => :'fedExMeterNumber',
        :'auto_purge_audits' => :'autoPurgeAudits',
        :'password_minimum_numeric_char' => :'passwordMinimumNumericChar',
        :'duns' => :'duns',
        :'email_sales' => :'emailSales',
        :'fed_ex_password' => :'fedExPassword',
        :'email_production' => :'emailProduction',
        :'ups_password' => :'upsPassword',
        :'display_navigator' => :'displayNavigator',
        :'maintenance_mode' => :'maintenanceMode',
        :'memory_maximum_recommended' => :'memoryMaximumRecommended',
        :'legacy_invoice_forms' => :'legacyInvoiceForms',
        :'password_minimum_alpha_char_lowercase' => :'passwordMinimumAlphaCharLowercase',
        :'email_inventory' => :'emailInventory',
        :'ups_username' => :'upsUsername',
        :'payment_gateway_name' => :'paymentGatewayName',
        :'eula_user' => :'eulaUser',
        :'email_personnel' => :'emailPersonnel',
        :'eula_time' => :'eulaTime',
        :'num_audit_records_per_object' => :'numAuditRecordsPerObject',
        :'use_company_name_for_root_label' => :'useCompanyNameForRootLabel',
        :'show_last_login' => :'showLastLogin',
        :'email_technical' => :'emailTechnical',
        :'maintenance_start_time' => :'maintenanceStartTime',
        :'validate_internal_only_emails' => :'validateInternalOnlyEmails',
        :'use_ldap_authentication' => :'useLdapAuthentication',
        :'disable_emailing' => :'disableEmailing',
        :'check_white_listed_attachment_type' => :'checkWhiteListedAttachmentType',
        :'number_of_required_system_notifications' => :'numberOfRequiredSystemNotifications',
        :'max_import_pace_connects' => :'maxImportPaceConnects',
        :'password_minimum_alpha_char_uppercase' => :'passwordMinimumAlphaCharUppercase',
        :'internal_ip_ranges' => :'internalIPRanges',
        :'case_sensitive_search' => :'caseSensitiveSearch',
        :'redirect_on_session_timeout' => :'redirectOnSessionTimeout',
        :'payment_gateway_url2' => :'paymentGatewayURL2',
        :'send_manual_email_via' => :'sendManualEmailVia',
        :'last_inventory_calc' => :'lastInventoryCalc',
        :'default_save_email_setting' => :'defaultSaveEmailSetting',
        :'prevent_duplicate_contacts' => :'preventDuplicateContacts',
        :'metric' => :'metric',
        :'password_minimum_non_alpha_non_numeric_char' => :'passwordMinimumNonAlphaNonNumericChar',
        :'max_import_control' => :'maxImportControl',
        :'max_import_template_objects' => :'maxImportTemplateObjects',
        :'current_organization_company' => :'currentOrganizationCompany',
        :'security_enabled' => :'securityEnabled',
        :'email_job_billing' => :'emailJobBilling',
        :'eula_accepted' => :'eulaAccepted',
        :'max_import_records' => :'maxImportRecords',
        :'hide_error_stack_trace' => :'hideErrorStackTrace',
        :'email_scheduling' => :'emailScheduling',
        :'email_customer_service' => :'emailCustomerService',
        :'auto_logoff_timeout' => :'autoLogoffTimeout',
        :'point_release_version' => :'pointReleaseVersion',
        :'disable_customizations' => :'disableCustomizations',
        :'max_days_audits' => :'maxDaysAudits',
        :'alternate_text' => :'alternateText',
        :'default_ldap_group' => :'defaultLdapGroup',
        :'password_previous_to_check' => :'passwordPreviousToCheck',
        :'disk_space_warning' => :'diskSpaceWarning',
        :'transaction_key' => :'transactionKey',
        :'try_to_prevent_browser_using_saved_passwords' => :'tryToPreventBrowserUsingSavedPasswords',
        :'eula_date' => :'eulaDate',
        :'search_wrapping_wildcards' => :'searchWrappingWildcards',
        :'fed_ex_server' => :'fedExServer',
        :'allow_duplicate_job_contacts' => :'allowDuplicateJobContacts',
        :'new_version_available' => :'newVersionAvailable',
        :'theme_location' => :'themeLocation',
        :'email_purchasing' => :'emailPurchasing',
        :'disable_parallel_grid_data_fetch' => :'disableParallelGridDataFetch',
        :'password_minimum_length' => :'passwordMinimumLength',
        :'maintenance_end_time' => :'maintenanceEndTime',
        :'md5_value' => :'md5Value',
        :'email_accounting' => :'emailAccounting',
        :'max_import_parameter' => :'maxImportParameter',
        :'breadcrumb_root_label' => :'breadcrumbRootLabel',
        :'old_size_denominator' => :'oldSizeDenominator',
        :'ups_access_code' => :'upsAccessCode',
        :'email_system_admin' => :'emailSystemAdmin',
        :'ldap_realm' => :'ldapRealm',
        :'base_currency' => :'baseCurrency',
        :'password_failures_before_lockout' => :'passwordFailuresBeforeLockout',
        :'disable_auto_login' => :'disableAutoLogin',
        :'use_secure_id_in_url' => :'useSecureIdInURL',
        :'report_analytical_data' => :'reportAnalyticalData',
        :'upgrade_mode' => :'upgradeMode',
        :'max_import_template_x_path_variables' => :'maxImportTemplateXPathVariables',
        :'duplicate_content_file_with_estimate_and_job' => :'duplicateContentFileWithEstimateAndJob',
        :'max_import_control_x_path' => :'maxImportControlXPath',
        :'email_gl' => :'emailGL',
        :'sso_service_provider_url' => :'ssoServiceProviderURL',
        :'show_workbench_dashboard' => :'showWorkbenchDashboard',
        :'size_denominator' => :'sizeDenominator',
        :'maximum_dropdown_limit' => :'maximumDropdownLimit',
        :'alt_phone_number' => :'altPhoneNumber',
        :'max_import_templates' => :'maxImportTemplates',
        :'number_of_system_notifications' => :'numberOfSystemNotifications',
        :'form_session_expiration_time' => :'formSessionExpirationTime',
        :'send_order_confirmation_message' => :'sendOrderConfirmationMessage',
        :'email_payables' => :'emailPayables',
        :'maximum_continuations_per_user' => :'maximumContinuationsPerUser',
        :'edi_user' => :'ediUser'
      }
    end
  end
end
