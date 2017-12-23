module RadCommon
  module ApplicationHelper
    def format_date(value)
      value.strftime("%-m/%-d/%Y") if value.present?
    end

    def format_date_long(value)
      value.strftime("%B %e, %Y") if value.present?
    end

    def format_datetime(value, options = {})
      return nil if value.blank?
      format_string = "%-m/%-d/%Y %l:%M"
      format_string = format_string + ":%S" if options[:include_seconds]
      format_string = format_string + " %p"
      format_string = format_string + " %Z" if options[:include_zone]
      value.in_time_zone.strftime(format_string)
    end

    def format_time(value)
      value.strftime("%l:%M%P") if value.present?
    end

    def format_boolean(value)
      if value
        content_tag(:div, nil, class: "fa fa-check")
      else
        content_tag(:div, nil, class: "fa fa-circle-o")
      end
    end

    def bootstrap_class_for flash_type
      case flash_type.to_s
        when "success"
          "alert-success"
        when "error"
          "alert-danger"
        when "alert"
          "alert-warning"
        when "notice"
          "alert-info"
        else
          flash_type.to_s
      end
    end

    def icon_tag(icon, text)
      content_tag(:i, "", class: "right-5px #{icon}") + text
    end

    def timezone_us_filter
      regex_str = ActiveSupport::TimeZone.us_zones.map{ |z| z.name }.join('|')
      regex_str.gsub!("(", "\\(", )
      regex_str.gsub!(")", "\\)", )
      regex_str = "(" + regex_str + ")"
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
  end
end
