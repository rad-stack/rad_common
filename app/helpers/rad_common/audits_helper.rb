module RadCommon
  module AuditsHelper
    def display_audited_changes(audit)
      audit_text = formatted_audited_changes(audit)

      if audit_text.present? && audit.comment.present?
        "#{audit_text}\n#{audit.comment}"
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

    def audits_title(audits, audit_search)
      return "Audits (#{audits.total_count})" unless audit_search.single_record?

      record = audit_search.single_record
      safe_join(['Audits for ', audit_model_link(nil, record), " (#{audits.total_count})"])
    end

    def safe_auditable(audit)
      return unless auditable_exists?(audit)

      audit.auditable
    end

    def auditable_exists?(audit)
      Module.const_defined?(audit.auditable_type)
    end

    def audit_model_link(audit, record)
      label = audit_link_label(audit, record)

      return label if audit.nil? && record.nil?
      return link_to(label, record) if record.present? && show_route_exists?(record) && policy(record).show?

      label
    end

    private

      def audit_link_label(audit, record)
        if record.present? && record.is_a?(ActionText::RichText)
          "Rich Text for #{record.record.class} #{record.record_id}"
        elsif record.present? && record.respond_to?(:to_s)
          "#{record.class} - #{record}"
        else
          "#{audit.auditable_type} (#{audit.auditable_id})"
        end
      end

      def formatted_audited_changes(audit)
        return 'deleted record' if audit.action == 'destroy' && audit.associated.blank?

        changes = audit.audited_changes
        return '' if changes.blank?

        audit_text = ''
        any_restricted = RadConfig.restricted_audit_attributes!.count.positive?

        changes.each do |change|
          changed_attribute = change.first

          if change[1].instance_of?(Array)
            from_value = formatted_audit_value(audit, changed_attribute, change[1][0])
            to_value = formatted_audit_value(audit, changed_attribute, change[1][1])
          else
            from_value = nil
            to_value = formatted_audit_value(audit, changed_attribute, change[1])
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
          audit_text += "<strong>#{to_value}</strong>\n"
        end

        audit_text
      end

      def formatted_audit_value(audit, attribute, raw_value)
        return raw_value unless auditable_exists?(audit)

        record = audit.auditable
        return raw_value unless record&.defined_enums&.has_key?(attribute)

        RadEnum.new(record.class, attribute).raw_translation(raw_value)
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

        restricted_attributes = RadConfig.restricted_audit_attributes!
        return if restricted_attributes.count.zero?

        matches = restricted_attributes.select do |item|
          item[:model] == audit.auditable_type && item[:attribute] == changed_attribute
        end

        matches.count.positive?
      end
  end
end
