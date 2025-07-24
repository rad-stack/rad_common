module Pace
  class Report < Base
    attr_accessor :name

    attr_accessor :_module

    attr_accessor :id

    attr_accessor :active

    attr_accessor :display_name

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :system_generated

    attr_accessor :network_location

    attr_accessor :base_object

    attr_accessor :default_email_template

    attr_accessor :internal_only

    attr_accessor :attachment_category

    attr_accessor :include_in_context_x_path

    attr_accessor :replace_existing

    attr_accessor :show_logo

    attr_accessor :export_type_forced

    attr_accessor :prompt_export_type

    attr_accessor :default_report_printer

    attr_accessor :export_name_x_path

    attr_accessor :display_name_forced

    attr_accessor :prompt_crystal_clear_version_forced

    attr_accessor :archive_on_preview

    attr_accessor :show_logo_forced

    attr_accessor :crystal_clear_version

    attr_accessor :attachment_description_expression

    attr_accessor :data_preparer_forced

    attr_accessor :base_object_forced

    attr_accessor :file_path_expression

    attr_accessor :archive_on_print

    attr_accessor :condition

    attr_accessor :name_forced

    attr_accessor :report_orientation

    attr_accessor :allow_refresh_forced

    attr_accessor :data_preparer

    attr_accessor :report_size

    attr_accessor :metadata_content_expression

    attr_accessor :file_name_expression

    attr_accessor :attach_as_link

    attr_accessor :allow_refresh

    attr_accessor :description_forced

    attr_accessor :crystal_clear_version_forced

    attr_accessor :default_font

    attr_accessor :add_metadata_file

    attr_accessor :archive_on_email

    attr_accessor :report_version_category

    attr_accessor :prompt_crystal_clear_version

    attr_accessor :export_type

    attr_accessor :metadata_file_suffix

    attr_accessor :report_parameters_forced

    attr_accessor :archive_report_to

    attr_accessor :prompt_export_type_forced


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'_module' => :'module',
        :'id' => :'id',
        :'active' => :'active',
        :'display_name' => :'displayName',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'category' => :'category',
        :'system_generated' => :'systemGenerated',
        :'network_location' => :'networkLocation',
        :'base_object' => :'baseObject',
        :'default_email_template' => :'defaultEmailTemplate',
        :'internal_only' => :'internalOnly',
        :'attachment_category' => :'attachmentCategory',
        :'include_in_context_x_path' => :'includeInContextXPath',
        :'replace_existing' => :'replaceExisting',
        :'show_logo' => :'showLogo',
        :'export_type_forced' => :'exportTypeForced',
        :'prompt_export_type' => :'promptExportType',
        :'default_report_printer' => :'defaultReportPrinter',
        :'export_name_x_path' => :'exportNameXPath',
        :'display_name_forced' => :'displayNameForced',
        :'prompt_crystal_clear_version_forced' => :'promptCrystalClearVersionForced',
        :'archive_on_preview' => :'archiveOnPreview',
        :'show_logo_forced' => :'showLogoForced',
        :'crystal_clear_version' => :'crystalClearVersion',
        :'attachment_description_expression' => :'attachmentDescriptionExpression',
        :'data_preparer_forced' => :'dataPreparerForced',
        :'base_object_forced' => :'baseObjectForced',
        :'file_path_expression' => :'filePathExpression',
        :'archive_on_print' => :'archiveOnPrint',
        :'condition' => :'condition',
        :'name_forced' => :'nameForced',
        :'report_orientation' => :'reportOrientation',
        :'allow_refresh_forced' => :'allowRefreshForced',
        :'data_preparer' => :'dataPreparer',
        :'report_size' => :'reportSize',
        :'metadata_content_expression' => :'metadataContentExpression',
        :'file_name_expression' => :'fileNameExpression',
        :'attach_as_link' => :'attachAsLink',
        :'allow_refresh' => :'allowRefresh',
        :'description_forced' => :'descriptionForced',
        :'crystal_clear_version_forced' => :'crystalClearVersionForced',
        :'default_font' => :'defaultFont',
        :'add_metadata_file' => :'addMetadataFile',
        :'archive_on_email' => :'archiveOnEmail',
        :'report_version_category' => :'reportVersionCategory',
        :'prompt_crystal_clear_version' => :'promptCrystalClearVersion',
        :'export_type' => :'exportType',
        :'metadata_file_suffix' => :'metadataFileSuffix',
        :'report_parameters_forced' => :'reportParametersForced',
        :'archive_report_to' => :'archiveReportTo',
        :'prompt_export_type_forced' => :'promptExportTypeForced'
      }
    end
  end
end
