module RadReports
  class ColumnDiscovery
    DEFAULT_EXCLUDED_COLUMNS = %w[
      encrypted_password
      reset_password_token
      reset_password_sent_at
      remember_created_at
      confirmation_token
      invitation_token
      confirmed_at
      confirmation_sent_at
      unconfirmed_email
      unlock_token
      failed_attempts
      locked_at
      otp_secret
      otp_secret_key
      encrypted_otp_secret
      encrypted_otp_secret_key
      encrypted_otp_secret_iv
      encrypted_otp_secret_salt
      consumed_timestep
      otp_backup_codes
      sign_in_count
      current_sign_in_at
      last_sign_in_at
      current_sign_in_ip
      last_sign_in_ip
    ].freeze

    attr_reader :model_name, :joins

    def initialize(model_name, joins = [])
      @model_name = model_name
      @joins = Array(joins)
    end

    def all_columns
      return [] if model_name.blank?

      klass = model_name.constantize
      columns = build_columns_for_model(klass)

      joins.each do |join_path|
        columns.concat(build_columns_for_association(klass, join_path))
      end

      columns
    rescue StandardError
      []
    end

    def columns_by_table
      all_columns.group_by do |column|
        {
          table: column[:table],
          label: column[:association_label] || column[:table_label],
          class_label: column[:table_label],
          association: column[:association]
        }
      end
    end

    def column_exists?(column_reference)
      return false if column_reference.blank?

      # Split from the right to handle nested joins (e.g., "project.client.name")
      parts = column_reference.split('.')
      col_name = parts.last
      table_or_association = parts[0..-2].join('.')

      valid_columns = all_columns

      matching_column = valid_columns.find do |vc|
        vc[:name] == col_name &&
          (vc[:association] == table_or_association ||
           vc[:table] == table_or_association ||
           (vc[:association].nil? && table_or_association.blank?))
      end

      matching_column.present?
    end

    private

      def build_columns_for_model(klass, association_info = {})
        database_columns = build_database_columns(klass, association_info)
        rich_text_columns = build_rich_text_columns(klass, association_info)
        attachment_columns = build_attachment_columns(klass, association_info)

        database_columns + rich_text_columns + attachment_columns
      end

      def build_database_columns(klass, association_info)
        klass.columns.filter_map do |column|
          next if should_exclude_column?(klass, column.name)

          build_column_definition(column, klass, association_info)
        end
      end

      def build_columns_for_association(base_klass, join_path)
        target_class = navigate_association_path(base_klass, join_path)
        return [] unless target_class

        association_info = build_association_info(target_class, join_path)
        build_columns_for_model(target_class, association_info)
      end

      def navigate_association_path(base_klass, join_path)
        parts = join_path.split('.')
        current_class = base_klass

        parts.each do |part|
          association = current_class.reflect_on_association(part.to_sym)
          return nil unless association

          current_class = association.klass
        end

        current_class
      end

      def build_association_info(klass, join_path)
        {
          association: join_path,
          association_label: join_path.split('.').map(&:titleize).join(' → '),
          table_label: klass.model_name.human,
          table: klass.table_name
        }
      end

      def build_column_definition(column, klass, association_info)
        {
          name: column.name,
          type: determine_column_type(column),
          table: association_info[:table] || klass.table_name,
          table_label: association_info[:table_label] || klass.model_name.human,
          association: association_info[:association],
          association_label: association_info[:association_label],
          is_foreign_key: foreign_key_column?(klass, column.name),
          is_enum: enum_column?(klass, column.name)
        }
      end

      def determine_column_type(column)
        column.respond_to?(:array) && column.array ? 'array' : column.type
      end

      def build_rich_text_columns(klass, association_info)
        klass.reflect_on_all_associations.filter_map do |assoc|
          next unless rich_text_association?(assoc)

          attr_name = extract_rich_text_attribute_name(assoc)
          next if should_exclude_column?(klass, attr_name)

          build_virtual_column_definition(attr_name, :rich_text, klass, association_info)
        end
      rescue StandardError
        []
      end

      def rich_text_association?(association)
        association.klass.name == 'ActionText::RichText' &&
          association.name.to_s.start_with?('rich_text_')
      end

      def extract_rich_text_attribute_name(association)
        association.name.to_s.sub('rich_text_', '')
      end

      def build_attachment_columns(klass, association_info)
        klass.reflect_on_all_associations.filter_map do |assoc|
          next unless attachment_association?(assoc)

          attr_name = extract_attachment_attribute_name(assoc)
          next unless attr_name
          next if should_exclude_column?(klass, attr_name)

          build_virtual_column_definition(attr_name, :attachment, klass, association_info)
        end
      rescue StandardError
        []
      end

      def attachment_association?(association)
        association.klass.name == 'ActiveStorage::Attachment'
      end

      def extract_attachment_attribute_name(association)
        # has_one_attached :avatar creates 'avatar_attachment'
        # has_many_attached :files creates 'files_attachments'
        attr_name = association.name.to_s.sub(/_attachments?\z/, '')
        return nil if attr_name == association.name.to_s

        attr_name
      end

      def build_virtual_column_definition(name, type, klass, association_info)
        {
          name: name,
          type: type,
          table: association_info[:table] || klass.table_name,
          table_label: association_info[:table_label] || klass.model_name.human,
          association: association_info[:association],
          association_label: association_info[:association_label]
        }
      end

      def should_exclude_column?(klass, column_name)
        column_name_str = column_name.to_s

        DEFAULT_EXCLUDED_COLUMNS.include?(column_name_str) ||
          globally_excluded_columns.include?(column_name_str) ||
          excluded_columns_for_model(klass.name).include?(column_name_str)
      end

      def globally_excluded_columns
        @globally_excluded_columns ||= Array(RadConfig.custom_reports_config[:excluded_columns]).map(&:to_s)
      end

      def excluded_columns_for_model(model_name)
        @excluded_columns_by_model ||= begin
          model_exclusions = RadConfig.custom_reports_config[:model_column_exclusions] || {}
          model_exclusions.stringify_keys.transform_values { |cols| Array(cols).map(&:to_s) }
        end

        @excluded_columns_by_model[model_name] || []
      end

      def foreign_key_column?(model_class, column_name)
        return false unless column_name.end_with?('_id')

        model_class.reflect_on_all_associations.any? do |assoc|
          assoc.foreign_key.to_s == column_name
        end
      end

      def enum_column?(model_class, column_name)
        model_class.defined_enums.key?(column_name)
      end
  end
end
