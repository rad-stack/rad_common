module RadCommon
  module ApplicationHelper
    ALERT_TYPES = %i[success info warning danger].freeze unless const_defined?(:ALERT_TYPES)

    def secured_link(resource, format: nil)
      return unless resource

      if Pundit.policy!(current_user, resource).show?
        link_to(resource_name(resource), resource, format: format)
      else
        resource_name(resource)
      end
    end

    def show_route_exists_for?(record)
      Rails.application.routes.url_helpers.respond_to? "#{record.class.table_name.singularize}_path"
    end

    def current_instance_variable
      instance_variable_get("@#{controller_name.classify.underscore}")
    end

    def avatar_image(user, size)
      if RadicalConfig.avatar? && user.avatar.attached?
        image_tag(user.avatar.variant(resize: '50x50'))
      else
        image_tag(gravatar_for(user, size))
      end
    end

    def gravatar_for(user, size)
      size = size_symbol_to_int(size) if size.is_a?(Symbol)
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=mm"
    end

    def show_actions?(klass)
      Pundit.policy!(current_user, klass.new).update? || Pundit.policy!(current_user, klass.new).destroy?
    end

    def address_show_data(record)
      items = [{ label: 'Address', value: record.full_address }]

      if record.bypass_address_validation?
        items.push({ label: 'Address Info',
                     value: content_tag(:span, 'address validation bypassed', class: 'badge alert-warning') })

      end

      if record.address_changes.present?
        items.push({ label: 'Address Changed',
                     value: content_tag(:span, record.address_changes, class: 'badge alert-warning') })

        record.clear_address_changes!
      end

      if record.address_problems.present?
        items.push({ label: 'Address Problems',
                     value: content_tag(:span, record.address_problems, class: 'badge alert-danger') })
      end

      items
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
      format_string += ':%S' if options[:include_seconds]
      format_string += ' %p'
      format_string += ' %Z' if options[:include_zone]
      value.in_time_zone.strftime(format_string)
    end

    def format_time(value)
      value.strftime('%l:%M%P').strip if value.present?
    end

    def rad_form_errors(form)
      return form.error_notification if form.object.blank?

      message = "Please review the problems below: #{form.object.errors.full_messages.to_sentence}"
      form.error_notification message: message
    end

    def format_boolean(value)
      if value
        tag.div(nil, class: 'fa fa-check')
      else
        tag.div(nil, class: 'fa fa-regular fa-circle')
      end
    end

    def formatted_decimal_hours(total_minutes)
      return if total_minutes.blank?

      (total_minutes / 60.0).round(2)
    end

    def icon_tag(icon, text)
      tag.i('', class: "mr-2 #{icon}") + text
    end

    def timezone_us_filter
      regex_str = ActiveSupport::TimeZone.us_zones.map(&:name).join('|')
      regex_str.gsub!('(', '\\(')
      regex_str.gsub!(')', '\\)')
      regex_str = "(#{regex_str})"
      Regexp.new regex_str
    end

    def enum_to_translated_option(record, enum_name)
      RadicalEnum.new(record.class, enum_name).translated_option(record)
    end

    def options_for_enum(klass, enum_name)
      RadicalEnum.new(klass, enum_name).options
    end

    def enum_translation(klass, enum_name, value)
      RadicalEnum.new(klass, enum_name).translation(value)
    end

    def bootstrap_flash
      flash_messages = []

      flash.each do |type, message|
        # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
        next if message.blank?

        type = bootstrap_flash_type(type)
        next unless ALERT_TYPES.include?(type)

        Array(message).each do |msg|
          flash_messages << tag.div(bootstrap_flash_close_button + msg, class: "alert in alert-#{type}") if msg
        end
      end

      safe_join flash_messages
    end

    def bootstrap_flash_type(type)
      type = type.to_sym

      type = :success if type == :notice
      type = :danger  if type == :alert
      type = :danger  if type == :error

      type
    end

    def bootstrap_flash_close_button
      tag.button(sanitize('&times;'), type: 'button', class: 'close', 'data-dismiss': 'alert')
    end

    def icon(icon, text = nil, options = {})
      text_class = text.present? ? 'mr-2' : nil
      capture do
        concat tag.i('', class: "fa fa-#{icon} #{text_class} #{options[:class]}".strip)
        concat text
      end
    end

    def verify_sign_up
      raise RadicallyIntermittentException if RadicalConfig.disable_sign_up?
    end

    def sign_up_roles
      SecurityRole.allow_sign_up.by_name
    end

    def invite_roles
      SecurityRole.allow_invite.by_name
    end

    def verify_invite
      raise RadicallyIntermittentException if RadicalConfig.disable_invite?
    end

    def verify_manually_create_users
      return if RadicalConfig.manually_create_users?

      raise RadicallyIntermittentException
    end

    def export_button(model_name)
      return unless policy(model_name.constantize.new).export?

      link_to(icon(:file, 'Export to File'),
              send("export_#{model_name.tableize}_path", params.permit!.to_h.merge(format: :csv)),
              class: 'btn btn-secondary btn-sm')
    end

    def onboarded?
      Onboarding.new(current_user).onboarded?
    end

    private

      def size_symbol_to_int(size_as_symbol)
        { small: 25,
          medium: 50,
          large: 200 }[size_as_symbol]
      end

      def resource_name(resource)
        resource.to_s
      end
  end
end
