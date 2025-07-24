module Pace
  class Job < Base
    attr_accessor :reference

    attr_accessor :priority

    attr_accessor :state

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :job

    attr_accessor :csr

    attr_accessor :sales_category

    attr_accessor :plant_manager_id

    attr_accessor :crm_id

    attr_accessor :contact_last_name

    attr_accessor :certification_authority

    attr_accessor :contact_first_name

    attr_accessor :certification_level

    attr_accessor :salutation

    attr_accessor :price_list

    attr_accessor :ship_via

    attr_accessor :allowable_overs

    attr_accessor :terms

    attr_accessor :ship_in_name_of

    attr_accessor :sales_person

    attr_accessor :profile_token

    attr_accessor :legal_entity

    attr_accessor :tax_category

    attr_accessor :manufacturing_location

    attr_accessor :item_template

    attr_accessor :entered_by

    attr_accessor :customer

    attr_accessor :date_time_setup

    attr_accessor :alt_currency_rate

    attr_accessor :alt_currency

    attr_accessor :alt_currency_rate_source_note

    attr_accessor :alt_currency_rate_source

    attr_accessor :quantity_ordered

    attr_accessor :charge_back_account

    attr_accessor :combo_job_percentage_calculation_type

    attr_accessor :user_interface_set

    attr_accessor :qty_ordered

    attr_accessor :total_parts

    attr_accessor :routing_template

    attr_accessor :qty_shipped

    attr_accessor :quantity_remaining

    attr_accessor :scheduled_flag

    attr_accessor :jdf_submitted

    attr_accessor :job_contact

    attr_accessor :metrix_id

    attr_accessor :scheduled

    attr_accessor :queue_entry_id

    attr_accessor :w2p_shipping_amount

    attr_accessor :original_quoted_price_forced

    attr_accessor :w2p_tax_amount

    attr_accessor :invoice_w2_p_tax_amount

    attr_accessor :w2p_handling_amount

    attr_accessor :status_reason

    attr_accessor :qty_billed

    attr_accessor :status_comment

    attr_accessor :pending_billed_amt

    attr_accessor :last_status_changed_date_time

    attr_accessor :invoice_w2_p_order_amount

    attr_accessor :job_type

    attr_accessor :created_by_connect

    attr_accessor :invoice_w2_p_shipping_amount

    attr_accessor :mdff_order_status

    attr_accessor :invoice_w2_p_handling_amount

    attr_accessor :ship_to_job_contact

    attr_accessor :status_reason_comment

    attr_accessor :billed_amt

    attr_accessor :sub_job_type

    attr_accessor :job_product_type

    attr_accessor :earliest_start_date_time

    attr_accessor :original_quoted_price

    attr_accessor :quote_number

    attr_accessor :pnref

    attr_accessor :shopping_cart

    attr_accessor :mxml

    attr_accessor :change_order_total

    attr_accessor :tax_category_forced

    attr_accessor :sales_category_forced

    attr_accessor :invoice_uom_forced

    attr_accessor :invoice_uom

    attr_accessor :freight_amount_total

    attr_accessor :amount_to_invoice_forced

    attr_accessor :amount_invoiced

    attr_accessor :amount_to_invoice

    attr_accessor :freight_on_board

    attr_accessor :promise_date_time

    attr_accessor :opportunity

    attr_accessor :invoice_level_options

    attr_accessor :bill_parts_together_attribute

    attr_accessor :job_project

    attr_accessor :committed_from_metrix

    attr_accessor :po_num

    attr_accessor :routing_identifier

    attr_accessor :deposit_amount

    attr_accessor :import_id

    attr_accessor :job_plan_links_enabled

    attr_accessor :pre_press_scheduled

    attr_accessor :pageflex_order_id

    attr_accessor :start_number

    attr_accessor :product_order

    attr_accessor :bill_to_job_contact

    attr_accessor :combo_job_validation_warning

    attr_accessor :new_jdfid

    attr_accessor :finishing_scheduled

    attr_accessor :bill_parts_together

    attr_accessor :jde_document_type

    attr_accessor :payment_authorization_card_expiration

    attr_accessor :payment_authorization_cardholder_address1

    attr_accessor :earliest_proof_ship_time

    attr_accessor :number_note

    attr_accessor :earliest_proof_due_date

    attr_accessor :print_stream_payment_method

    attr_accessor :dsf_credit_card_finalized

    attr_accessor :created_from_ansix12850

    attr_accessor :web_order_id

    attr_accessor :printable_order_id

    attr_accessor :default_product

    attr_accessor :jdf_submit_queue_entry_error

    attr_accessor :payment_authorization_cardholder_city

    attr_accessor :mdff_order_created

    attr_accessor :payment_authorization_amount

    attr_accessor :job_value

    attr_accessor :payment_authorization_time

    attr_accessor :combo_dirty

    attr_accessor :number_prefix

    attr_accessor :job_jacket_version

    attr_accessor :job_order_type

    attr_accessor :mdff_order_tech_message

    attr_accessor :prev_status_reason_comment

    attr_accessor :bill_part_one_only_attribute

    attr_accessor :printable_swo_id

    attr_accessor :iway_order_id

    attr_accessor :scheduled_ship_time_forced

    attr_accessor :isbn

    attr_accessor :description2

    attr_accessor :suppress_email

    attr_accessor :prev_status_reason

    attr_accessor :admin_status

    attr_accessor :dsf_payment_method

    attr_accessor :scheduled_ship_date_time

    attr_accessor :note_to_add

    attr_accessor :metrix_prepress_jdf

    attr_accessor :part1_job_product_type

    attr_accessor :overs_method

    attr_accessor :reprint_type

    attr_accessor :combo_total

    attr_accessor :prompt_for_multiple_parts

    attr_accessor :numbers_guaranteed

    attr_accessor :payment_authorization_billing_name

    attr_accessor :default_part_quantity

    attr_accessor :itemized_invoicing

    attr_accessor :total_order_lines

    attr_accessor :execute_sync

    attr_accessor :converting_to_job

    attr_accessor :pre_press_scheduled_flag

    attr_accessor :payment_authorization_cardholder_state

    attr_accessor :prev_admin_status

    attr_accessor :dsf_order_id

    attr_accessor :payment_authorization_date

    attr_accessor :payment_profile_token

    attr_accessor :current_status

    attr_accessor :earliest_proof_ship_date

    attr_accessor :ready_to_schedule

    attr_accessor :metrix_prepress_stripping_jdf

    attr_accessor :print_stream_order_id

    attr_accessor :iway_user_id

    attr_accessor :earliest_proof_due_time

    attr_accessor :earliest_proof_ship_date_time

    attr_accessor :prompt_for_multiple_products

    attr_accessor :quantity_ordered_forced

    attr_accessor :payment_authorization_card_type

    attr_accessor :part1_quoted_price

    attr_accessor :part1_quantity_ordered

    attr_accessor :free_form_account_number

    attr_accessor :payment_authorization_token

    attr_accessor :finishing_scheduled_flag

    attr_accessor :destination_based_taxing

    attr_accessor :number_positions

    attr_accessor :total_price_all_parts

    attr_accessor :use_legacy_print_flow_format_pre_press

    attr_accessor :epace_estimate

    attr_accessor :add_plan_from_job_type

    attr_accessor :part1_num_sigs

    attr_accessor :ignore_item_template_finalize_print_flow

    attr_accessor :scheduled_ship_date_forced

    attr_accessor :web_id

    attr_accessor :parent_job

    attr_accessor :payment_authorization_cardholder_zip

    attr_accessor :prev_status_comment

    attr_accessor :use_legacy_print_flow_format_finishing

    attr_accessor :earliest_proof_due

    attr_accessor :mdff_order_reject_flag


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'reference' => :'reference',
        :'priority' => :'priority',
        :'state' => :'state',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'job' => :'job',
        :'csr' => :'csr',
        :'sales_category' => :'salesCategory',
        :'plant_manager_id' => :'plantManagerId',
        :'crm_id' => :'crmId',
        :'contact_last_name' => :'contactLastName',
        :'certification_authority' => :'certificationAuthority',
        :'contact_first_name' => :'contactFirstName',
        :'certification_level' => :'certificationLevel',
        :'salutation' => :'salutation',
        :'price_list' => :'priceList',
        :'ship_via' => :'shipVia',
        :'allowable_overs' => :'allowableOvers',
        :'terms' => :'terms',
        :'ship_in_name_of' => :'shipInNameOf',
        :'sales_person' => :'salesPerson',
        :'profile_token' => :'profileToken',
        :'legal_entity' => :'legalEntity',
        :'tax_category' => :'taxCategory',
        :'manufacturing_location' => :'manufacturingLocation',
        :'item_template' => :'itemTemplate',
        :'entered_by' => :'enteredBy',
        :'customer' => :'customer',
        :'date_time_setup' => :'dateTimeSetup',
        :'alt_currency_rate' => :'altCurrencyRate',
        :'alt_currency' => :'altCurrency',
        :'alt_currency_rate_source_note' => :'altCurrencyRateSourceNote',
        :'alt_currency_rate_source' => :'altCurrencyRateSource',
        :'quantity_ordered' => :'quantityOrdered',
        :'charge_back_account' => :'chargeBackAccount',
        :'combo_job_percentage_calculation_type' => :'comboJobPercentageCalculationType',
        :'user_interface_set' => :'userInterfaceSet',
        :'qty_ordered' => :'qtyOrdered',
        :'total_parts' => :'totalParts',
        :'routing_template' => :'routingTemplate',
        :'qty_shipped' => :'qtyShipped',
        :'quantity_remaining' => :'quantityRemaining',
        :'scheduled_flag' => :'scheduledFlag',
        :'jdf_submitted' => :'jdfSubmitted',
        :'job_contact' => :'jobContact',
        :'metrix_id' => :'metrixID',
        :'scheduled' => :'scheduled',
        :'queue_entry_id' => :'queueEntryID',
        :'w2p_shipping_amount' => :'w2pShippingAmount',
        :'original_quoted_price_forced' => :'originalQuotedPriceForced',
        :'w2p_tax_amount' => :'w2pTaxAmount',
        :'invoice_w2_p_tax_amount' => :'invoiceW2PTaxAmount',
        :'w2p_handling_amount' => :'w2pHandlingAmount',
        :'status_reason' => :'statusReason',
        :'qty_billed' => :'qtyBilled',
        :'status_comment' => :'statusComment',
        :'pending_billed_amt' => :'pendingBilledAmt',
        :'last_status_changed_date_time' => :'lastStatusChangedDateTime',
        :'invoice_w2_p_order_amount' => :'invoiceW2POrderAmount',
        :'job_type' => :'jobType',
        :'created_by_connect' => :'createdByConnect',
        :'invoice_w2_p_shipping_amount' => :'invoiceW2PShippingAmount',
        :'mdff_order_status' => :'mdffOrderStatus',
        :'invoice_w2_p_handling_amount' => :'invoiceW2PHandlingAmount',
        :'ship_to_job_contact' => :'shipToJobContact',
        :'status_reason_comment' => :'statusReasonComment',
        :'billed_amt' => :'billedAmt',
        :'sub_job_type' => :'subJobType',
        :'job_product_type' => :'jobProductType',
        :'earliest_start_date_time' => :'earliestStartDateTime',
        :'original_quoted_price' => :'originalQuotedPrice',
        :'quote_number' => :'quoteNumber',
        :'pnref' => :'pnref',
        :'shopping_cart' => :'shoppingCart',
        :'mxml' => :'mxml',
        :'change_order_total' => :'changeOrderTotal',
        :'tax_category_forced' => :'taxCategoryForced',
        :'sales_category_forced' => :'salesCategoryForced',
        :'invoice_uom_forced' => :'invoiceUOMForced',
        :'invoice_uom' => :'invoiceUOM',
        :'freight_amount_total' => :'freightAmountTotal',
        :'amount_to_invoice_forced' => :'amountToInvoiceForced',
        :'amount_invoiced' => :'amountInvoiced',
        :'amount_to_invoice' => :'amountToInvoice',
        :'freight_on_board' => :'freightOnBoard',
        :'promise_date_time' => :'promiseDateTime',
        :'opportunity' => :'opportunity',
        :'invoice_level_options' => :'invoiceLevelOptions',
        :'bill_parts_together_attribute' => :'billPartsTogetherAttribute',
        :'job_project' => :'jobProject',
        :'committed_from_metrix' => :'committedFromMetrix',
        :'po_num' => :'poNum',
        :'routing_identifier' => :'routingIdentifier',
        :'deposit_amount' => :'depositAmount',
        :'import_id' => :'importID',
        :'job_plan_links_enabled' => :'jobPlanLinksEnabled',
        :'pre_press_scheduled' => :'prePressScheduled',
        :'pageflex_order_id' => :'pageflexOrderID',
        :'start_number' => :'startNumber',
        :'product_order' => :'productOrder',
        :'bill_to_job_contact' => :'billToJobContact',
        :'combo_job_validation_warning' => :'comboJobValidationWarning',
        :'new_jdfid' => :'newJDFID',
        :'finishing_scheduled' => :'finishingScheduled',
        :'bill_parts_together' => :'billPartsTogether',
        :'jde_document_type' => :'jdeDocumentType',
        :'payment_authorization_card_expiration' => :'paymentAuthorizationCardExpiration',
        :'payment_authorization_cardholder_address1' => :'paymentAuthorizationCardholderAddress1',
        :'earliest_proof_ship_time' => :'earliestProofShipTime',
        :'number_note' => :'numberNote',
        :'earliest_proof_due_date' => :'earliestProofDueDate',
        :'print_stream_payment_method' => :'printStreamPaymentMethod',
        :'dsf_credit_card_finalized' => :'dsfCreditCardFinalized',
        :'created_from_ansix12850' => :'createdFromAnsix12850',
        :'web_order_id' => :'webOrderID',
        :'printable_order_id' => :'printableOrderID',
        :'default_product' => :'defaultProduct',
        :'jdf_submit_queue_entry_error' => :'jdfSubmitQueueEntryError',
        :'payment_authorization_cardholder_city' => :'paymentAuthorizationCardholderCity',
        :'mdff_order_created' => :'mdffOrderCreated',
        :'payment_authorization_amount' => :'paymentAuthorizationAmount',
        :'job_value' => :'jobValue',
        :'payment_authorization_time' => :'paymentAuthorizationTime',
        :'combo_dirty' => :'comboDirty',
        :'number_prefix' => :'numberPrefix',
        :'job_jacket_version' => :'jobJacketVersion',
        :'job_order_type' => :'jobOrderType',
        :'mdff_order_tech_message' => :'mdffOrderTechMessage',
        :'prev_status_reason_comment' => :'prevStatusReasonComment',
        :'bill_part_one_only_attribute' => :'billPartOneOnlyAttribute',
        :'printable_swo_id' => :'printableSwoID',
        :'iway_order_id' => :'iwayOrderID',
        :'scheduled_ship_time_forced' => :'scheduledShipTimeForced',
        :'isbn' => :'isbn',
        :'description2' => :'description2',
        :'suppress_email' => :'suppressEmail',
        :'prev_status_reason' => :'prevStatusReason',
        :'admin_status' => :'adminStatus',
        :'dsf_payment_method' => :'dsfPaymentMethod',
        :'scheduled_ship_date_time' => :'scheduledShipDateTime',
        :'note_to_add' => :'noteToAdd',
        :'metrix_prepress_jdf' => :'metrixPrepressJDF',
        :'part1_job_product_type' => :'part1JobProductType',
        :'overs_method' => :'oversMethod',
        :'reprint_type' => :'reprintType',
        :'combo_total' => :'comboTotal',
        :'prompt_for_multiple_parts' => :'promptForMultipleParts',
        :'numbers_guaranteed' => :'numbersGuaranteed',
        :'payment_authorization_billing_name' => :'paymentAuthorizationBillingName',
        :'default_part_quantity' => :'defaultPartQuantity',
        :'itemized_invoicing' => :'itemizedInvoicing',
        :'total_order_lines' => :'totalOrderLines',
        :'execute_sync' => :'executeSync',
        :'converting_to_job' => :'convertingToJob',
        :'pre_press_scheduled_flag' => :'prePressScheduledFlag',
        :'payment_authorization_cardholder_state' => :'paymentAuthorizationCardholderState',
        :'prev_admin_status' => :'prevAdminStatus',
        :'dsf_order_id' => :'dsfOrderID',
        :'payment_authorization_date' => :'paymentAuthorizationDate',
        :'payment_profile_token' => :'paymentProfileToken',
        :'current_status' => :'currentStatus',
        :'earliest_proof_ship_date' => :'earliestProofShipDate',
        :'ready_to_schedule' => :'readyToSchedule',
        :'metrix_prepress_stripping_jdf' => :'metrixPrepressStrippingJDF',
        :'print_stream_order_id' => :'printStreamOrderID',
        :'iway_user_id' => :'iwayUserId',
        :'earliest_proof_due_time' => :'earliestProofDueTime',
        :'earliest_proof_ship_date_time' => :'earliestProofShipDateTime',
        :'prompt_for_multiple_products' => :'promptForMultipleProducts',
        :'quantity_ordered_forced' => :'quantityOrderedForced',
        :'payment_authorization_card_type' => :'paymentAuthorizationCardType',
        :'part1_quoted_price' => :'part1QuotedPrice',
        :'part1_quantity_ordered' => :'part1QuantityOrdered',
        :'free_form_account_number' => :'freeFormAccountNumber',
        :'payment_authorization_token' => :'paymentAuthorizationToken',
        :'finishing_scheduled_flag' => :'finishingScheduledFlag',
        :'destination_based_taxing' => :'destinationBasedTaxing',
        :'number_positions' => :'numberPositions',
        :'total_price_all_parts' => :'totalPriceAllParts',
        :'use_legacy_print_flow_format_pre_press' => :'useLegacyPrintFlowFormatPrePress',
        :'epace_estimate' => :'epaceEstimate',
        :'add_plan_from_job_type' => :'addPlanFromJobType',
        :'part1_num_sigs' => :'part1NumSigs',
        :'ignore_item_template_finalize_print_flow' => :'ignoreItemTemplateFinalizePrintFlow',
        :'scheduled_ship_date_forced' => :'scheduledShipDateForced',
        :'web_id' => :'webID',
        :'parent_job' => :'parentJob',
        :'payment_authorization_cardholder_zip' => :'paymentAuthorizationCardholderZip',
        :'prev_status_comment' => :'prevStatusComment',
        :'use_legacy_print_flow_format_finishing' => :'useLegacyPrintFlowFormatFinishing',
        :'earliest_proof_due' => :'earliestProofDue',
        :'mdff_order_reject_flag' => :'mdffOrderRejectFlag'
      }
    end
  end
end
