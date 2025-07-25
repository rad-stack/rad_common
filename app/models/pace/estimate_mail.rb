module Pace
  class EstimateMail < Base
    attr_accessor :id

    attr_accessor :versions

    attr_accessor :distribution

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :estimate_part

    attr_accessor :insert_type

    attr_accessor :instructions

    attr_accessor :clean_list

    attr_accessor :matched_mailing

    attr_accessor :aspect_ratio

    attr_accessor :extra_stock

    attr_accessor :permit_print

    attr_accessor :drop_date

    attr_accessor :return_address

    attr_accessor :remove_duplicate_address

    attr_accessor :barcode

    attr_accessor :mailing_type

    attr_accessor :print_case

    attr_accessor :list_source

    attr_accessor :ncoa_list

    attr_accessor :permit_billing

    attr_accessor :samples

    attr_accessor :duplicate_address

    attr_accessor :field_for_de_dupe

    attr_accessor :fields_included

    attr_accessor :return_print

    attr_accessor :de_dupe_type

    attr_accessor :mailing_prepared_for

    attr_accessor :co_mingle

    attr_accessor :remove_undeliverable

    attr_accessor :mailing_tabs

    attr_accessor :mailing_class

    attr_accessor :mailing_size

    attr_accessor :postage_type

    attr_accessor :permit_used

    attr_accessor :print_type

    attr_accessor :address_format

    attr_accessor :drop_time

    attr_accessor :processed

    attr_accessor :cass_list

    attr_accessor :remove_internaltional


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'versions' => :'versions',
        :'distribution' => :'distribution',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'estimate_part' => :'estimatePart',
        :'insert_type' => :'insertType',
        :'instructions' => :'instructions',
        :'clean_list' => :'cleanList',
        :'matched_mailing' => :'matchedMailing',
        :'aspect_ratio' => :'aspectRatio',
        :'extra_stock' => :'extraStock',
        :'permit_print' => :'permitPrint',
        :'drop_date' => :'dropDate',
        :'return_address' => :'returnAddress',
        :'remove_duplicate_address' => :'removeDuplicateAddress',
        :'barcode' => :'barcode',
        :'mailing_type' => :'mailingType',
        :'print_case' => :'printCase',
        :'list_source' => :'listSource',
        :'ncoa_list' => :'ncoaList',
        :'permit_billing' => :'permitBilling',
        :'samples' => :'samples',
        :'duplicate_address' => :'duplicateAddress',
        :'field_for_de_dupe' => :'fieldForDeDupe',
        :'fields_included' => :'fieldsIncluded',
        :'return_print' => :'returnPrint',
        :'de_dupe_type' => :'deDupeType',
        :'mailing_prepared_for' => :'mailingPreparedFor',
        :'co_mingle' => :'coMingle',
        :'remove_undeliverable' => :'removeUndeliverable',
        :'mailing_tabs' => :'mailingTabs',
        :'mailing_class' => :'mailingClass',
        :'mailing_size' => :'mailingSize',
        :'postage_type' => :'postageType',
        :'permit_used' => :'permitUsed',
        :'print_type' => :'printType',
        :'address_format' => :'addressFormat',
        :'drop_time' => :'dropTime',
        :'processed' => :'processed',
        :'cass_list' => :'cassList',
        :'remove_internaltional' => :'removeInternaltional'
      }
    end
  end
end
