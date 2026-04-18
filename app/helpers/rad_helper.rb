module RadHelper
  ALERT_TYPES = %i[success info warning danger].freeze unless const_defined?(:ALERT_TYPES)

  IOS_SPLASH_SCREENS = [
    ['/apple-splash-2048-2732.png', '(device-width: 1024px) and (device-height: 1366px) and (-webkit-device-pixel-ratio: 2) and (orientation: portrait)'],
    ['/apple-splash-2732-2048.png', '(device-width: 1024px) and (device-height: 1366px) and (-webkit-device-pixel-ratio: 2) and (orientation: landscape)'],
    ['/apple-splash-1668-2388.png', '(device-width: 834px) and (device-height: 1194px) and (-webkit-device-pixel-ratio: 2) and (orientation: portrait)'],
    ['/apple-splash-2388-1668.png', '(device-width: 834px) and (device-height: 1194px) and (-webkit-device-pixel-ratio: 2) and (orientation: landscape)'],
    ['/apple-splash-1536-2048.png', '(device-width: 768px) and (device-height: 1024px) and (-webkit-device-pixel-ratio: 2) and (orientation: portrait)'],
    ['/apple-splash-2048-1536.png', '(device-width: 768px) and (device-height: 1024px) and (-webkit-device-pixel-ratio: 2) and (orientation: landscape)'],
    ['/apple-splash-1640-2360.png', '(device-width: 820px) and (device-height: 1180px) and (-webkit-device-pixel-ratio: 2) and (orientation: portrait)'],
    ['/apple-splash-2360-1640.png', '(device-width: 820px) and (device-height: 1180px) and (-webkit-device-pixel-ratio: 2) and (orientation: landscape)'],
    ['/apple-splash-1668-2224.png', '(device-width: 834px) and (device-height: 1112px) and (-webkit-device-pixel-ratio: 2) and (orientation: portrait)'],
    ['/apple-splash-2224-1668.png', '(device-width: 834px) and (device-height: 1112px) and (-webkit-device-pixel-ratio: 2) and (orientation: landscape)'],
    ['/apple-splash-1620-2160.png', '(device-width: 810px) and (device-height: 1080px) and (-webkit-device-pixel-ratio: 2) and (orientation: portrait)'],
    ['/apple-splash-2160-1620.png', '(device-width: 810px) and (device-height: 1080px) and (-webkit-device-pixel-ratio: 2) and (orientation: landscape)'],
    ['/apple-splash-1488-2266.png', '(device-width: 744px) and (device-height: 1133px) and (-webkit-device-pixel-ratio: 2) and (orientation: portrait)'],
    ['/apple-splash-2266-1488.png', '(device-width: 744px) and (device-height: 1133px) and (-webkit-device-pixel-ratio: 2) and (orientation: landscape)'],
    ['/apple-splash-1320-2868.png', '(device-width: 440px) and (device-height: 956px) and (-webkit-device-pixel-ratio: 3) and (orientation: portrait)'],
    ['/apple-splash-2868-1320.png', '(device-width: 440px) and (device-height: 956px) and (-webkit-device-pixel-ratio: 3) and (orientation: landscape)'],
    ['/apple-splash-1206-2622.png', '(device-width: 402px) and (device-height: 874px) and (-webkit-device-pixel-ratio: 3) and (orientation: portrait)'],
    ['/apple-splash-2622-1206.png', '(device-width: 402px) and (device-height: 874px) and (-webkit-device-pixel-ratio: 3) and (orientation: landscape)'],
    ['/apple-splash-1260-2736.png', '(device-width: 420px) and (device-height: 912px) and (-webkit-device-pixel-ratio: 3) and (orientation: portrait)'],
    ['/apple-splash-2736-1260.png', '(device-width: 420px) and (device-height: 912px) and (-webkit-device-pixel-ratio: 3) and (orientation: landscape)'],
    ['/apple-splash-1290-2796.png', '(device-width: 430px) and (device-height: 932px) and (-webkit-device-pixel-ratio: 3) and (orientation: portrait)'],
    ['/apple-splash-2796-1290.png', '(device-width: 430px) and (device-height: 932px) and (-webkit-device-pixel-ratio: 3) and (orientation: landscape)'],
    ['/apple-splash-1179-2556.png', '(device-width: 393px) and (device-height: 852px) and (-webkit-device-pixel-ratio: 3) and (orientation: portrait)'],
    ['/apple-splash-2556-1179.png', '(device-width: 393px) and (device-height: 852px) and (-webkit-device-pixel-ratio: 3) and (orientation: landscape)'],
    ['/apple-splash-1170-2532.png', '(device-width: 390px) and (device-height: 844px) and (-webkit-device-pixel-ratio: 3) and (orientation: portrait)'],
    ['/apple-splash-2532-1170.png', '(device-width: 390px) and (device-height: 844px) and (-webkit-device-pixel-ratio: 3) and (orientation: landscape)'],
    ['/apple-splash-1284-2778.png', '(device-width: 428px) and (device-height: 926px) and (-webkit-device-pixel-ratio: 3) and (orientation: portrait)'],
    ['/apple-splash-2778-1284.png', '(device-width: 428px) and (device-height: 926px) and (-webkit-device-pixel-ratio: 3) and (orientation: landscape)'],
    ['/apple-splash-1125-2436.png', '(device-width: 375px) and (device-height: 812px) and (-webkit-device-pixel-ratio: 3) and (orientation: portrait)'],
    ['/apple-splash-2436-1125.png', '(device-width: 375px) and (device-height: 812px) and (-webkit-device-pixel-ratio: 3) and (orientation: landscape)'],
    ['/apple-splash-1242-2688.png', '(device-width: 414px) and (device-height: 896px) and (-webkit-device-pixel-ratio: 3) and (orientation: portrait)'],
    ['/apple-splash-2688-1242.png', '(device-width: 414px) and (device-height: 896px) and (-webkit-device-pixel-ratio: 3) and (orientation: landscape)'],
    ['/apple-splash-828-1792.png', '(device-width: 414px) and (device-height: 896px) and (-webkit-device-pixel-ratio: 2) and (orientation: portrait)'],
    ['/apple-splash-1792-828.png', '(device-width: 414px) and (device-height: 896px) and (-webkit-device-pixel-ratio: 2) and (orientation: landscape)'],
    ['/apple-splash-1242-2208.png', '(device-width: 414px) and (device-height: 736px) and (-webkit-device-pixel-ratio: 3) and (orientation: portrait)'],
    ['/apple-splash-2208-1242.png', '(device-width: 414px) and (device-height: 736px) and (-webkit-device-pixel-ratio: 3) and (orientation: landscape)'],
    ['/apple-splash-750-1334.png', '(device-width: 375px) and (device-height: 667px) and (-webkit-device-pixel-ratio: 2) and (orientation: portrait)'],
    ['/apple-splash-1334-750.png', '(device-width: 375px) and (device-height: 667px) and (-webkit-device-pixel-ratio: 2) and (orientation: landscape)'],
    ['/apple-splash-640-1136.png', '(device-width: 320px) and (device-height: 568px) and (-webkit-device-pixel-ratio: 2) and (orientation: portrait)'],
    ['/apple-splash-1136-640.png', '(device-width: 320px) and (device-height: 568px) and (-webkit-device-pixel-ratio: 2) and (orientation: landscape)']
  ].freeze

  def ios_splash_screen_tags
    safe_join(IOS_SPLASH_SCREENS.map { |href, media| tag.link(rel: 'apple-touch-startup-image', href: href, media: media) })
  end

  def secured_link(record, format: nil, new_tab: false)
    return unless record

    style = secured_link_style(record)

    if user_signed_in? && show_route_exists?(record) && Pundit.policy!(current_user, record).show?
      if new_tab
        link_to record.to_s, record, format: format, class: style, target: '_blank', rel: 'noopener'
      else
        link_to record.to_s, record, format: format, class: style
      end
    elsif style.present?
      content_tag :span, record, class: style
    else
      record.to_s
    end
  end

  def show_route_exists?(record)
    RadHelper.show_routes.include?(record.class.name)
  end

  def avatar_image(user, size)
    if RadConfig.avatar? && user.avatar.attached?
      image_tag(user.avatar.variant(resize_to_limit: [50, 50]))
    else
      image_tag(gravatar_for(user, size))
    end
  end

  def gravatar_for(user, size)
    size = size_symbol_to_int(size) if size.is_a?(Symbol)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=mm"
  end

  def show_actions?(item)
    unless item.respond_to?(:each)
      return Pundit.policy!(current_user, item.new).update? || Pundit.policy!(current_user, item.new).destroy?
    end

    item.each do |record|
      return true if Pundit.policy!(current_user, record).update? || Pundit.policy!(current_user, record).destroy?
    end

    false
  end

  def address_show_data(record)
    items = [{ label: 'Address', value: record.full_address }]

    if record.bypass_address_validation?
      items.push(
        { label: 'Address Info',
          value: content_tag(:span, 'address validation bypassed', class: 'badge bg-warning bg-opacity-75') }
      )
    end

    if record.address_changes.present?
      items.push({ label: 'Address Changed',
                   value: content_tag(:span, record.address_changes, class: 'badge bg-warning bg-opacity-75') })

      record.clear_address_changes!
    end

    if record.address_problems.present?
      items.push({ label: 'Address Problems',
                   value: content_tag(:span, record.address_problems, class: 'badge bg-danger bg-opacity-75') })
    end

    items
  end

  def datetime_in_words(datetime)
    safe_join([tag.p { format_datetime datetime },
               tag.p { "#{distance_of_time_in_words_to_now(datetime)} ago" }])
  end

  def date_in_words(date)
    return if date.blank?

    safe_join([tag.p(class: 'mb-0') { format_date date },
               tag.small(class: 'text-muted') { "#{distance_of_time_in_words_to_now(date)} ago" }])
  end

  def format_date(value)
    value.strftime('%-m/%-d/%Y') if value.present?
  end

  def format_date_long(value)
    value.strftime('%B %e, %Y') if value.present?
  end

  def format_datetime(value, options = {})
    return nil if value.blank?

    format_string = '%-m/%-d/%Y %-l:%M'
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
    tag.i('', class: "me-2 #{icon}") + text
  end

  def timezone_us_filter
    regex_str = ActiveSupport::TimeZone.us_zones.map(&:name).join('|')
    regex_str.gsub!('(', '\\(')
    regex_str.gsub!(')', '\\)')
    regex_str = "(#{regex_str})"
    Regexp.new regex_str
  end

  def bootstrap_flash
    flash_messages = []

    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      type = bootstrap_flash_type(type)
      next unless ALERT_TYPES.include?(type)

      Array(message).each do |msg|
        alert_class = "alert alert-dismissible in alert-#{type}"
        flash_messages << tag.div(bootstrap_flash_close_button + msg, class: alert_class) if msg
      end
    end

    safe_join flash_messages
  end

  def bootstrap_flash_type(type)
    type = type.to_sym

    type = :success if type == :notice && RadConfig.legacy_assets?
    type = :danger  if type == :alert
    type = :danger  if type == :error

    type
  end

  def bootstrap_flash_close_button
    tag.button('', type: 'button', class: 'btn-close me-2', 'data-bs-dismiss': 'alert')
  end

  def table_row_style(record, style_class: 'table-danger')
    return unless record.present? && record.respond_to?(:active?) && !record.active?

    style_class
  end

  def secured_link_style(record)
    return unless record.present? && record.respond_to?(:active?) && !record.active?

    'text-danger'
  end

  def icon(icon, text = nil, options = {})
    allowed_styles = %w[fa fab far fas fal]
    style = options.fetch(:style, 'fa')

    unless allowed_styles.include?(style)
      raise ArgumentError, "Invalid Font Awesome style: '#{style}'. Allowed styles are: #{allowed_styles.join(', ')}"
    end

    text_class = text.present? ? 'me-2' : nil
    capture do
      concat tag.i('', class: "#{style} fa-#{icon} #{text_class} #{options[:class]}".strip)
      concat text
    end
  end

  def verify_sign_up
    raise RadIntermittentException if RadConfig.disable_sign_up?
  end

  def sign_up_roles
    SecurityRole.allow_sign_up.sorted
  end

  def invite_roles
    SecurityRole.allow_invite.sorted
  end

  def invite_role_options
    SecurityRole.allow_invite.sorted.map { |role| [role.to_s, role.id, { data: { external: role.external? } }] }
  end

  def verify_invite
    raise RadIntermittentException if RadConfig.disable_invite?
  end

  def verify_manually_create_users
    return if RadConfig.manually_create_users?

    raise RadIntermittentException
  end

  def export_button(model_name, format: Exporter::DEFAULT_FORMAT, override_path: nil, additional_params: {},
                    policy_model: nil)
    return unless policy(policy_model.presence || model_name.constantize.new).export?

    icon, text = format == :csv ? [:file, 'Export to File'] : ['file-pdf', 'Export to PDF']
    export_path = override_path.presence || "export_#{model_name.tableize}_path"
    link_to(icon(icon, text),
            send(export_path, params.permit!.to_h.merge(format: format).deep_merge(additional_params)),
            class: 'btn btn-secondary btn-sm')
  end

  def export_buttons(model_name, **)
    %i[csv pdf].map { |format| export_button(model_name, format: format, **) }.compact
  end

  def onboarded?
    Onboarding.new(current_user).onboarded?
  end

  def pdf_output?
    return true if request.nil?

    request.format.pdf?
  end

  def created_by_show_item(record)
    { label: 'Created By', value: secured_link(record.created_by) }
  end

  def translated_attribute_label(record, attribute)
    translation = I18n.t "activerecord.attributes.#{record.class.to_s.underscore}.#{attribute}"

    if translation.downcase.include?('translation missing')
      attribute.to_s.titlecase
    else
      translation
    end
  end

  def rad_wicked_pdf_stylesheet_link_tag(source)
    # Hack until https://github.com/mileszs/wicked_pdf/pull/1120 is merged
    protocol = Rails.env.production? || Rails.env.staging? ? 'https' : 'http'
    stylesheet_link_tag source, host: "#{protocol}://#{RadConfig.host_name!}"
  end

  def rad_turbo_form_options(template_locals, options = {})
    options[:data] ||= {}
    options[:data].merge!(
      controller: 'remote-form',
      remote_form_success_message_value: template_locals[:toast_success],
      remote_form_error_message_value: template_locals[:toast_error],
      remote_form_target: 'form'
    )
    options
  end

  def rad_toast_data(template_locals)
    { 'toast-success-message-value': template_locals[:toast_success] || template_locals[:notice],
      'toast-error-message-value': template_locals[:toast_error],
      controller: 'toast' }
  end

  def check_blob_validity(blob)
    unless RadCommon::VALID_ATTACHMENT_TYPES.include?(blob.content_type)
      raise "Invalid attachment type #{blob.content_type}"
    end

    raise 'Invalid attachment, must be 100 MB or less' if blob.byte_size > 100.megabytes
  end

  def portal_subdomain?
    return false unless RadConfig.portal?

    request.subdomain == 'patient' || request.subdomain.starts_with?('patient-staging')
  end

  def application_page_title
    return RadConfig.app_name! unless RadConfig.portal?

    if request.subdomain.starts_with? 'patient'
      RadConfig.config_item!(:portal_app_name)
    elsif request.subdomain.starts_with? 'prescriber'
      RadConfig.config_item!(:portal_app_name).gsub('Patient', 'Prescriber')
    else
      RadConfig.app_name!
    end
  end

  class << self
    def show_routes
      @show_routes ||= AppInfo.new.show_routes
    end
  end

  private

    def size_symbol_to_int(size_as_symbol)
      { small: 25,
        medium: 50,
        large: 200 }[size_as_symbol]
    end
end
