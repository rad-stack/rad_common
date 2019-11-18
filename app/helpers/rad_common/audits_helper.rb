module RadCommon
  module AuditsHelper
    def display_audited_changes(audit)
      audit_text = formatted_audited_changes(audit)

      if audit_text.present? && audit.comment.present?
        audit_text + "\n" + audit.comment
      elsif audit_text.present?
        audit_text
      elsif audit.comment.present?
        audit.comment
      else
        ''
      end
    end

    def display_audited_action(audit)
      # TODO: handle other associated models

      action = if audit.associated.present? && audit.auditable_type == 'ActiveStorage::Attachment'
                 "#{audit.action} attachment"
               else
                 audit.action
               end

      action.gsub('destroy', 'delete')
    end

    def audit_title(by_user)
      title = by_user ? 'Updates by ' : 'Updates for '
      title = (title + audit_model_link(nil, @model_object)).html_safe if @model_object
      title += 'System' if by_user && @model_object.blank?
      title = (title + @deleted) if @deleted
      title + " (#{@audits.total_count})"
    end

    def audit_model_link(audit, model_object)
      label = if model_object.nil?
                "#{audit.auditable_type} (#{audit.auditable_id})"
              elsif model_object.respond_to?(:to_s)
                model_object.class.to_s + ' - ' + model_object.to_s
              else
                label = "#{audit.auditable_type} (#{audit.auditable_id})"
              end

      if (audit.nil? && model_object.nil?) || model_object.class.name == 'Rate' || model_object.class.name == 'DraftInvoice'
        # TODO: ignore this some other way rather than by hardcoding name
        label
      else
        if model_object.nil?
          label
        elsif show_path_exists?(model_object) && policy(model_object).show?
          link_to label, model_object
        else
          label
        end
      end
    end

    def audit_models_to_search
      models = ActiveRecord::Base.connection.tables.map do |model|
        model.capitalize.singularize.camelize.safe_constantize
      end

      models.uniq.select { |model| model.respond_to?(:auditing_enabled) && model.auditing_enabled }.map(&:to_s).sort
    end

    private

      def show_path_exists?(model_object)
        respond_to? "#{model_object.class.table_name.singularize}_path"
      end

      def formatted_audited_changes(audit)
        return 'deleted record' if audit.action == 'destroy' && audit.associated.blank?

        changes = audit.audited_changes
        return '' if changes.blank?

        audit_text = ''
        any_restricted = Rails.application.config.restricted_audit_attributes.count.positive?

        changes.each do |change|
          changed_attribute = change.first

          if change[1].class.name == 'Array'
            from_value = change[1][0]
            to_value = change[1][1]
          else
            from_value = nil
            to_value = change[1]
          end

          next if (from_value.blank? && to_value.blank?) || (from_value.to_s == to_value.to_s)

          action_label = audit.action == 'destroy' ? 'Deleted' : 'Changed'

          if any_restricted && restricted_audit_attribute?(audit, changed_attribute, current_user)
            from_value = 'XXX' if from_value.present?
            to_value = 'XXX' if to_value.present?
          end

          audit_text += "#{action_label} <strong>#{changed_attribute.titlecase}</strong> "
          klass = classify_foreign_key(changed_attribute, audit.auditable_type.safe_constantize)

          if klass.is_a?(Class)
            if klass.respond_to?('find_by_id')
              to_instance = klass.find_by(id: to_value)
              from_instance = from_value.present? ? klass.find_by(id: from_value) : nil

              from_value = from_instance.to_s if from_instance
              to_value = to_instance.to_s if to_instance
            elsif klass.respond_to?(:find)
              to_instance = klass.find(to_value)
              from_instance = from_value.present? ? klass.find(from_value) : nil

              from_value = from_instance.to_s if from_instance
              to_value = to_instance.to_s if to_instance
            end
          end

          audit_text += "from <strong>#{from_value}</strong> " if from_value
          audit_text += 'to ' unless audit.action == 'destroy' && audit.associated.present?
          audit_text += "<strong>#{to_value}</strong>" + "\n"
        end

        audit_text
      end

      def classify_foreign_key(audit_column, audit_type)
        reflections = if audit_type.respond_to?(:reflect_on_all_associations)
                        audit_type.reflect_on_all_associations(:belongs_to).select { |r| r.foreign_key == audit_column }
                      end

        return reflections.first.class_name.safe_constantize if reflections&.any?

        if audit_column =~ /_id$/
          attr = audit_column.sub(/_id$/, '')
          attr = attr.classify.safe_constantize
        else
          attr = nil
        end

        attr.nil? ? audit_column : attr
      end

      def restricted_audit_attribute?(audit, changed_attribute, current_user)
        return false if current_user.admin?

        restricted_attributes = Rails.application.config.restricted_audit_attributes
        return if restricted_attributes.count.zero?

        matches = restricted_attributes.select { |item| item[:model] == audit.auditable_type && item[:attribute] == changed_attribute }
        matches.count.positive?
      end
  end
end
