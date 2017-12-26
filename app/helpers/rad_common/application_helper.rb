module RadCommon
  module ApplicationHelper
    def display_audited_changes(audit)
      if audit.action == "destroy"
        return "deleted record"
      else
        changes = audit.audited_changes
        audit_text = ""

        changes.each do |change|
          if change[1].class.name == "Array"
            from_value = change[1][0]
            to_value = change[1][1]
          else
            from_value = nil
            to_value = change[1]
          end

          if !((from_value.blank? && to_value.blank?) || (from_value.to_s == to_value.to_s))
            audit_text = audit_text + "Changed <strong>#{change[0].titlecase}</strong> "
            if from_value
              audit_text = audit_text + "from <strong>#{from_value}</strong> "
            end

            audit_text = audit_text + "to <strong>#{to_value}</strong>" + "\n"
          end
        end

        return audit_text
      end
    end

    def audit_model_link(audit, model_object)
      if model_object.nil?
        label = "#{audit.auditable_type} (#{audit.auditable_id})"
      elsif model_object.respond_to?(:to_s)
        label = model_object.class.to_s + " - " + model_object.to_s
      elsif model_object.respond_to?(:name)
        label = model_object.class.to_s + " - " + model_object.name
      else
        if audit.nil?
          label = model_object.class.to_s
        else
          label = "#{audit.auditable_type} (#{audit.auditable_id})"
        end
      end

      if audit.nil? || model_object.nil? || model_object.class.name == "Rate" || model_object.class.name == "DraftInvoice"
        #todo ignore this some other way rather than by hardcoding name
        return label
      else
        if model_object.class.to_s != "User" && current_member.can_read?(model_object)  #todo same as above
          link_to label, model_object
        else
          return label
        end
      end
    end

    def secured_link(resource, format: nil)
      return unless resource

      if current_member.can_read?(resource)
        link_to(resource_name(resource), resource, format: format)
      else
        resource_name(resource)
      end
    end

    def avatar_image(user, size)
      if Rails.application.config.use_avatar && user.respond_to?(:avatar) && user.avatar.present?
        image_tag(user.avatar.url(:medium))
      else
        image_tag(gravatar_for(user, size))
      end
    end

    def gravatar_for(user, size)
      size = size_symbol_to_int(size) if size.is_a?(Symbol)
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=mm"
    end

    def show_actions?(klass)
      current_member.can_update?(klass) || current_member.can_delete?(klass)
    end

    def format_date(value)
      value.strftime('%-m/%-d/%Y') if value.present?
    end

    def format_date_long(value)
      value.strftime('%B %e, %Y') if value.present?
    end

    def format_datetime(value, options = {})
      return nil if value.blank?
      format_string = '%-m/%-d/%Y %l:%M'
      format_string = format_string + ':%S' if options[:include_seconds]
      format_string = format_string + ' %p'
      format_string = format_string + ' %Z' if options[:include_zone]
      value.in_time_zone.strftime(format_string)
    end

    def format_time(value)
      value.strftime('%l:%M%P') if value.present?
    end

    def format_boolean(value)
      if value
        content_tag(:div, nil, class: 'fa fa-check')
      else
        content_tag(:div, nil, class: 'fa fa-circle-o')
      end
    end

    def bootstrap_class_for flash_type
      case flash_type.to_s
        when 'success'
          'alert-success'
        when 'error'
          'alert-danger'
        when 'alert'
          'alert-warning'
        when 'notice'
          'alert-info'
        else
          flash_type.to_s
      end
    end

    def icon_tag(icon, text)
      content_tag(:i, '', class: "right-5px #{icon}") + text
    end

    def timezone_us_filter
      regex_str = ActiveSupport::TimeZone.us_zones.map{ |z| z.name }.join('|')
      regex_str.gsub!("(", "\\(", )
      regex_str.gsub!(")", "\\)", )
      regex_str = '(' + regex_str + ')'
      Regexp.new regex_str
    end

    def enum_to_translated_option(klass, enum, enum_value, default = enum_value.to_s.titleize)
      key = "activerecord.attributes.#{klass.to_s.underscore.gsub('/', '_')}.#{enum}.#{enum_value}"
      I18n.t(key, default: default)
    end

    def options_for_enum(klass, enum)
      enums = enum.to_s.pluralize
      enum_values = klass.send(enums)
      enum_values.map do |enum_value, db_value|
        translated = enum_to_translated_option(klass, enums, enum_value)
        [translated, enum_value]
      end.reject {|translated, enum_value| translated.blank?}
    end

    def audit_models_to_search
      #todo dunno if we can get the list from the audited gem, if so, would be faster
      Audited::Audit.select(:auditable_type).distinct.pluck(:auditable_type)
    end

    def mailer_image_url(image)
      protocol = Rails.env.production? ? "https" : "http"
      "#{protocol}://#{ActionMailer::Base.default_url_options[:host]}/#{image}"
    end

    def classify_foreign_key(audit_column, audit_type)
      if audit_type.respond_to?(:reflect_on_all_associations)
        reflections = audit_type.reflect_on_all_associations(:belongs_to).select { |r| r.foreign_key == audit_column }
      else
        reflections = nil
      end

      if reflections && reflections.any?
        return reflections.first.class_name.safe_constantize
      end

      if audit_column =~ /_id$/
        attr = audit_column.sub(/_id$/, '')
        attr = attr.classify.safe_constantize
      else
        attr = nil
      end

      attr.nil? ? audit_column : attr
    end

    private

      def size_symbol_to_int(size_as_symbol)
        { small: 25,
          medium: 50,
          large: 200
        }[size_as_symbol]
      end

      def resource_name(resource)
        resource.to_s
      end
  end
end
