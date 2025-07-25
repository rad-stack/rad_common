module Pace
  class Contact < Base
    attr_accessor :id

    attr_accessor :state

    attr_accessor :active

    attr_accessor :country

    attr_accessor :email

    attr_accessor :position

    attr_accessor :title

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sales_tax2

    attr_accessor :default_currency

    attr_accessor :use_alternate_text

    attr_accessor :source_type

    attr_accessor :alt_state

    attr_accessor :web_site

    attr_accessor :alt_address3

    attr_accessor :alt_address1

    attr_accessor :alt_address2

    attr_accessor :business_id_number

    attr_accessor :state_key

    attr_accessor :alt_country

    attr_accessor :salutation

    attr_accessor :alt_city

    attr_accessor :ship_via

    attr_accessor :taxable_code

    attr_accessor :alt_salutation

    attr_accessor :terms

    attr_accessor :alt_zip

    attr_accessor :zip

    attr_accessor :city

    attr_accessor :sales_person

    attr_accessor :profile_token

    attr_accessor :sales_tax

    attr_accessor :map_site_url

    attr_accessor :shipping_acct_num

    attr_accessor :ship_bill_to_contact

    attr_accessor :alt_state_key

    attr_accessor :address3

    attr_accessor :address2

    attr_accessor :address1

    attr_accessor :vatid_number

    attr_accessor :customer

    attr_accessor :vendor

    attr_accessor :last_name

    attr_accessor :first_name

    attr_accessor :department

    attr_accessor :birth_date

    attr_accessor :system_user

    attr_accessor :latitude

    attr_accessor :longitude

    attr_accessor :job_contact

    attr_accessor :company_name

    attr_accessor :metro_area

    attr_accessor :tax_number

    attr_accessor :bill_to

    attr_accessor :ship_to

    attr_accessor :residential

    attr_accessor :prospect

    attr_accessor :company_legal_name

    attr_accessor :im_user_name

    attr_accessor :ssotoken

    attr_accessor :auto_update

    attr_accessor :failed_gps_lookup

    attr_accessor :twitter

    attr_accessor :linked_in

    attr_accessor :global_contact

    attr_accessor :metro_area_forced

    attr_accessor :email_label

    attr_accessor :dsf_user_name

    attr_accessor :dsf_ship_to

    attr_accessor :skype

    attr_accessor :lookup_hint

    attr_accessor :alt_bill

    attr_accessor :mobile_phone_number

    attr_accessor :email_label4

    attr_accessor :email_label3

    attr_accessor :email_label2

    attr_accessor :facebook

    attr_accessor :business_phone_extension

    attr_accessor :assistant_phone

    attr_accessor :home_phone_number

    attr_accessor :alt_auto_update

    attr_accessor :do_not_email

    attr_accessor :dsf_password

    attr_accessor :email3

    attr_accessor :email2

    attr_accessor :you_tube

    attr_accessor :email4

    attr_accessor :im_service

    attr_accessor :do_not_call

    attr_accessor :business_phone_number

    attr_accessor :needs_info

    attr_accessor :other_phone_number

    attr_accessor :dsf_user

    attr_accessor :pace_connect_contact_id

    attr_accessor :business_fax_extension

    attr_accessor :crm

    attr_accessor :assistant

    attr_accessor :customs_tax_id

    attr_accessor :home_fax_number

    attr_accessor :business_fax_number


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'state' => :'state',
        :'active' => :'active',
        :'country' => :'country',
        :'email' => :'email',
        :'position' => :'position',
        :'title' => :'title',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sales_tax2' => :'salesTax2',
        :'default_currency' => :'defaultCurrency',
        :'use_alternate_text' => :'useAlternateText',
        :'source_type' => :'sourceType',
        :'alt_state' => :'altState',
        :'web_site' => :'webSite',
        :'alt_address3' => :'altAddress3',
        :'alt_address1' => :'altAddress1',
        :'alt_address2' => :'altAddress2',
        :'business_id_number' => :'businessIdNumber',
        :'state_key' => :'stateKey',
        :'alt_country' => :'altCountry',
        :'salutation' => :'salutation',
        :'alt_city' => :'altCity',
        :'ship_via' => :'shipVia',
        :'taxable_code' => :'taxableCode',
        :'alt_salutation' => :'altSalutation',
        :'terms' => :'terms',
        :'alt_zip' => :'altZip',
        :'zip' => :'zip',
        :'city' => :'city',
        :'sales_person' => :'salesPerson',
        :'profile_token' => :'profileToken',
        :'sales_tax' => :'salesTax',
        :'map_site_url' => :'mapSiteURL',
        :'shipping_acct_num' => :'shippingAcctNum',
        :'ship_bill_to_contact' => :'shipBillToContact',
        :'alt_state_key' => :'altStateKey',
        :'address3' => :'address3',
        :'address2' => :'address2',
        :'address1' => :'address1',
        :'vatid_number' => :'vatidNumber',
        :'customer' => :'customer',
        :'vendor' => :'vendor',
        :'last_name' => :'lastName',
        :'first_name' => :'firstName',
        :'department' => :'department',
        :'birth_date' => :'birthDate',
        :'system_user' => :'systemUser',
        :'latitude' => :'latitude',
        :'longitude' => :'longitude',
        :'job_contact' => :'jobContact',
        :'company_name' => :'companyName',
        :'metro_area' => :'metroArea',
        :'tax_number' => :'taxNumber',
        :'bill_to' => :'billTo',
        :'ship_to' => :'shipTo',
        :'residential' => :'residential',
        :'prospect' => :'prospect',
        :'company_legal_name' => :'companyLegalName',
        :'im_user_name' => :'imUserName',
        :'ssotoken' => :'ssotoken',
        :'auto_update' => :'autoUpdate',
        :'failed_gps_lookup' => :'failedGPSLookup',
        :'twitter' => :'twitter',
        :'linked_in' => :'linkedIn',
        :'global_contact' => :'globalContact',
        :'metro_area_forced' => :'metroAreaForced',
        :'email_label' => :'emailLabel',
        :'dsf_user_name' => :'dsfUserName',
        :'dsf_ship_to' => :'dsfShipTo',
        :'skype' => :'skype',
        :'lookup_hint' => :'lookupHint',
        :'alt_bill' => :'altBill',
        :'mobile_phone_number' => :'mobilePhoneNumber',
        :'email_label4' => :'emailLabel4',
        :'email_label3' => :'emailLabel3',
        :'email_label2' => :'emailLabel2',
        :'facebook' => :'facebook',
        :'business_phone_extension' => :'businessPhoneExtension',
        :'assistant_phone' => :'assistantPhone',
        :'home_phone_number' => :'homePhoneNumber',
        :'alt_auto_update' => :'altAutoUpdate',
        :'do_not_email' => :'doNotEmail',
        :'dsf_password' => :'dsfPassword',
        :'email3' => :'email3',
        :'email2' => :'email2',
        :'you_tube' => :'youTube',
        :'email4' => :'email4',
        :'im_service' => :'imService',
        :'do_not_call' => :'doNotCall',
        :'business_phone_number' => :'businessPhoneNumber',
        :'needs_info' => :'needsInfo',
        :'other_phone_number' => :'otherPhoneNumber',
        :'dsf_user' => :'dsfUser',
        :'pace_connect_contact_id' => :'paceConnectContactID',
        :'business_fax_extension' => :'businessFaxExtension',
        :'crm' => :'crm',
        :'assistant' => :'assistant',
        :'customs_tax_id' => :'customsTaxID',
        :'home_fax_number' => :'homeFaxNumber',
        :'business_fax_number' => :'businessFaxNumber'
      }
    end
  end
end
