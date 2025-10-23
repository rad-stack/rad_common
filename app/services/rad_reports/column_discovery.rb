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
      @joins = joins
    end

    def all_columns
      return [] if model_name.blank?

      klass = model_name.constantize
      columns = []

      # Base model columns
      columns.concat(build_columns_for_model(klass))

      # Joined association columns
      joins.each do |join_path|
        columns.concat(build_columns_for_association(klass, join_path))
      end

      columns
    rescue StandardError
      []
    end

    def columns_by_table
      all_columns.group_by do |col|
        {
          table: col[:table],
          label: col[:association_label] || col[:table_label],
          class_label: col[:table_label],
          association: col[:association]
        }
      end
    end

    private

      def build_columns_for_model(klass, association_info = {})
        columns = []

        # Regular database columns
        klass.columns.each do |col|
          next if should_exclude_column?(klass, col.name)

          columns << build_column_definition(col, klass, association_info)
        end

        # Rich text columns
        columns.concat(build_rich_text_columns(klass, association_info))

        # Attachment columns
        columns.concat(build_attachment_columns(klass, association_info))

        columns
      end

      def build_columns_for_association(base_klass, join_path)
        # Navigate through nested path (e.g., "task.project.client")
        parts = join_path.split('.')
        current_class = base_klass

        parts.each do |part|
          association = current_class.reflect_on_association(part.to_sym)
          break unless association

          current_class = association.klass
        end

        return [] unless current_class

        association_label = join_path.split('.').map(&:titleize).join(' → ')
        class_label = current_class.model_name.human

        association_info = {
          association: join_path,
          association_label: association_label,
          table_label: class_label,
          table: current_class.table_name
        }

        build_columns_for_model(current_class, association_info)
      end

      def build_column_definition(col, klass, association_info)
        {
          name: col.name,
          type: col.type,
          table: association_info[:table] || klass.table_name,
          table_label: association_info[:table_label] || klass.model_name.human,
          association: association_info[:association],
          association_label: association_info[:association_label],
          is_foreign_key: foreign_key_column?(klass, col.name),
          is_enum: enum_column?(klass, col.name)
        }
      end

      def build_rich_text_columns(klass, association_info)
        klass.reflect_on_all_associations.filter_map do |assoc|
          next unless assoc.klass.name == 'ActionText::RichText'
          next unless assoc.name.to_s.start_with?('rich_text_')

          attr_name = assoc.name.to_s.sub('rich_text_', '')
          next if should_exclude_column?(klass, attr_name)

          {
            name: attr_name,
            type: :rich_text,
            table: association_info[:table] || klass.table_name,
            table_label: association_info[:table_label] || klass.model_name.human,
            association: association_info[:association],
            association_label: association_info[:association_label]
          }
        end
      rescue StandardError
        []
      end

      def build_attachment_columns(klass, association_info)
        klass.reflect_on_all_associations.filter_map do |assoc|
          next unless assoc.klass.name == 'ActiveStorage::Attachment'

          # has_one_attached :avatar creates 'avatar_attachment'
          # has_many_attached :files creates 'files_attachments'
          attr_name = assoc.name.to_s.sub(/_attachments?\z/, '')
          next if attr_name == assoc.name.to_s
          next if should_exclude_column?(klass, attr_name)

          {
            name: attr_name,
            type: :attachment,
            table: association_info[:table] || klass.table_name,
            table_label: association_info[:table_label] || klass.model_name.human,
            association: association_info[:association],
            association_label: association_info[:association_label]
          }
        end
      rescue StandardError
        []
      end

      def should_exclude_column?(klass, column_name)
        # Check default sensitive columns
        return true if DEFAULT_EXCLUDED_COLUMNS.include?(column_name.to_s)

        # Check global exclusions from config
        return true if globally_excluded_columns.include?(column_name.to_s)

        # Check model-specific exclusions from config
        model_exclusions = excluded_columns_for_model(klass.name)
        return true if model_exclusions.include?(column_name.to_s)

        false
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
