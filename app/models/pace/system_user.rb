module Pace
  class SystemUser < Base
    attr_accessor :active

    attr_accessor :locked

    attr_accessor :time_zone

    attr_accessor :user_name

    attr_accessor :password

    attr_accessor :email

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :default_contact

    attr_accessor :manufacturing_location

    attr_accessor :customer

    attr_accessor :secure_id

    attr_accessor :workstation

    attr_accessor :report_paper

    attr_accessor :default_customer

    attr_accessor :receivable_payment_group

    attr_accessor :default_employee

    attr_accessor :curr_successful_login_time

    attr_accessor :default_salesperson

    attr_accessor :number_of_required_notifications

    attr_accessor :additional_manufacturing_locations

    attr_accessor :allow_multiple_logins

    attr_accessor :last_successful_login_time

    attr_accessor :sso_user

    attr_accessor :default_bill_payment_batch

    attr_accessor :punchout_user_name

    attr_accessor :purchasing_approval_group

    attr_accessor :view_all_tips

    attr_accessor :expanded_menu_blade

    attr_accessor :no_password_required

    attr_accessor :number_of_system_notification_reads

    attr_accessor :pin_navigator

    attr_accessor :last_successful_login_date

    attr_accessor :default_printer

    attr_accessor :copy_me

    attr_accessor :allow_external_access

    attr_accessor :user_type

    attr_accessor :default_inquiry_navigator_closed

    attr_accessor :password_change_required

    attr_accessor :ldap_user

    attr_accessor :navigator_width

    attr_accessor :do_not_track_logon

    attr_accessor :max_recent_items

    attr_accessor :tips_viewed

    attr_accessor :number_of_notifications

    attr_accessor :last_quick_search_item

    attr_accessor :curr_successful_login_date

    attr_accessor :navigator_height

    attr_accessor :number_of_mandatory_system_notification_reads

    attr_accessor :view_shippable_only

    attr_accessor :default_csr

    attr_accessor :password_last_changed

    attr_accessor :default_estimator

    attr_accessor :email_display_name

    attr_accessor :failed_logins

    attr_accessor :sso_user_name


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'active' => :'active',
        :'locked' => :'locked',
        :'time_zone' => :'timeZone',
        :'user_name' => :'userName',
        :'password' => :'password',
        :'email' => :'email',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'default_contact' => :'defaultContact',
        :'manufacturing_location' => :'manufacturingLocation',
        :'customer' => :'customer',
        :'secure_id' => :'secureId',
        :'workstation' => :'workstation',
        :'report_paper' => :'reportPaper',
        :'default_customer' => :'defaultCustomer',
        :'receivable_payment_group' => :'receivablePaymentGroup',
        :'default_employee' => :'defaultEmployee',
        :'curr_successful_login_time' => :'currSuccessfulLoginTime',
        :'default_salesperson' => :'defaultSalesperson',
        :'number_of_required_notifications' => :'numberOfRequiredNotifications',
        :'additional_manufacturing_locations' => :'additionalManufacturingLocations',
        :'allow_multiple_logins' => :'allowMultipleLogins',
        :'last_successful_login_time' => :'lastSuccessfulLoginTime',
        :'sso_user' => :'ssoUser',
        :'default_bill_payment_batch' => :'defaultBillPaymentBatch',
        :'punchout_user_name' => :'punchoutUserName',
        :'purchasing_approval_group' => :'purchasingApprovalGroup',
        :'view_all_tips' => :'viewAllTips',
        :'expanded_menu_blade' => :'expandedMenuBlade',
        :'no_password_required' => :'noPasswordRequired',
        :'number_of_system_notification_reads' => :'numberOfSystemNotificationReads',
        :'pin_navigator' => :'pinNavigator',
        :'last_successful_login_date' => :'lastSuccessfulLoginDate',
        :'default_printer' => :'defaultPrinter',
        :'copy_me' => :'copyMe',
        :'allow_external_access' => :'allowExternalAccess',
        :'user_type' => :'userType',
        :'default_inquiry_navigator_closed' => :'defaultInquiryNavigatorClosed',
        :'password_change_required' => :'passwordChangeRequired',
        :'ldap_user' => :'ldapUser',
        :'navigator_width' => :'navigatorWidth',
        :'do_not_track_logon' => :'doNotTrackLogon',
        :'max_recent_items' => :'maxRecentItems',
        :'tips_viewed' => :'tipsViewed',
        :'number_of_notifications' => :'numberOfNotifications',
        :'last_quick_search_item' => :'lastQuickSearchItem',
        :'curr_successful_login_date' => :'currSuccessfulLoginDate',
        :'navigator_height' => :'navigatorHeight',
        :'number_of_mandatory_system_notification_reads' => :'numberOfMandatorySystemNotificationReads',
        :'view_shippable_only' => :'viewShippableOnly',
        :'default_csr' => :'defaultCsr',
        :'password_last_changed' => :'passwordLastChanged',
        :'default_estimator' => :'defaultEstimator',
        :'email_display_name' => :'emailDisplayName',
        :'failed_logins' => :'failedLogins',
        :'sso_user_name' => :'ssoUserName'
      }
    end
  end
end
