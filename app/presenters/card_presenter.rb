class CardPresenter
  attr_reader :local_assigns

  def initialize(view_context, local_assigns = nil)
    @view_context = view_context
    @local_assigns = local_assigns
  end

  def _h
    @view_context
  end

  delegate :params, to: :_h

  delegate :controller, to: :_h

  def controller_name
    local_assigns[:controller_name] || _h.controller_name
  end

  def downcased_object_class
    controller_name.classify.downcase
  end

  def instance
    controller.instance_variable_get(instance_variable_name) unless custom?
  end

  def instance_label
    instance.to_s unless custom?
  end

  def klass
    Object.const_get(controller_name.classify) unless custom?
  end

  def custom?
    action_name == 'custom'
  end

  def title
    local_assigns[:title]
  end

  def title_class
    local_assigns[:title_class] || ''
  end

  def icon
    local_assigns[:icon]
  end

  def no_new_button
    local_assigns[:no_new_button]
  end

  def no_edit_button
    local_assigns[:no_edit_button]
  end

  def no_delete_button
    local_assigns[:no_delete_button]
  end

  def no_index_button
    local_assigns[:no_index_button]
  end

  def no_show_link
    local_assigns[:no_show_link]
  end

  def no_back_button
    local_assigns[:no_back_button]
  end

  def additional_actions
    local_assigns[:additional_actions] || []
  end

  def additional_external_actions
    local_assigns[:additional_external_actions] || []
  end

  def external_actions
    local_assigns[:external_actions] || []
  end

  def action_name
    local_assigns[:action_name] || params[:action]
  end

  def new_url
    local_assigns[:new_url] || "/#{controller_name}/new"
  end

  def edit_url
    local_assigns[:edit_url] || "/#{controller_name}/#{params[:id]}/edit"
  end

  def delete_button_content
    local_assigns[:delete_button_content]
  end

  def instance_variable_name
    "@#{local_assigns[:instance_variable_name] || controller_name.classify.underscore}"
  end

  def delete_confirmation
    local_assigns[:delete_confirmation] || 'Are you sure?'
  end

  def index_path
    local_assigns[:index_path] || "/#{controller_name}"
  end

  def current_user
    @view_context.current_user
  end

  def output_icon
    return icon if icon.present?
    return 'fa-pencil' if action_name == 'edit' || action_name == 'update'
    return 'fa-plus' if action_name == 'new' || action_name == 'create'
    return 'fa-file' if action_name == 'show'
    return 'fa-list' if action_name == 'index'

    raise 'missing card header icon'
  end

  def card_style
    return local_assigns[:card_style] if local_assigns[:card_style].present?

    unless %w[show edit].include?(action_name) &&
           instance.present? &&
           instance.respond_to?(:active?) &&
           !instance.active?
      return
    end

    'bg-danger bg-opacity-25'
  end

  def output_title
    return title if title.present?
    return "New #{object_label}" if action_name == 'new' || action_name == 'create'
    return @output_title = "#{object_label}: #{instance_label}" if action_name == 'show'

    if action_name == 'index'
      the_var = controller.instance_variable_get("@#{controller_name}")
      return "#{object_label_plural} (#{the_var.respond_to?(:total_count) ? the_var.total_count : the_var.count})"
    end

    if action_name == 'edit' || action_name == 'update'
      title_items = ["Editing #{object_label}:"]

      title_items += if no_show_link
                       [' ', instance_label]
                     else
                       [' ', @view_context.link_to(instance_label, instance)]
                     end

      return @view_context.safe_join(title_items)
    end

    raise 'missing card header title'
  end

  def output_actions
    actions = []

    actions.push(edit_action) if include_edit_action?
    actions += additional_actions
    actions.push(duplicate_action) if include_duplicate_action?
    actions.push(duplicates_action) if include_duplicates_action?
    actions.push(delete_action) if include_delete_action?
    actions.push(tools_button) if include_tools_button?

    actions
  end

  def output_external_actions
    actions = []

    actions += external_actions

    if (action_name == 'edit' || action_name == 'update' || action_name == 'show') &&
       !no_new_button && current_user && class_policy.new?

      actions.push(@view_context.link_to(@view_context.icon('plus-square', "Add Another #{object_label}"),
                                         new_url,
                                         class: 'btn btn-success btn-sm',
                                         id: "new_#{downcased_object_class}_link"))
    end

    if show_index_button?
      actions.push(@view_context.link_to(@view_context.icon(:list, "View #{object_label_plural}"),
                                         index_path,
                                         class: 'btn btn-secondary btn-sm'))
    end

    if action_name == 'index' && !no_new_button && current_user && class_policy.new?
      actions.push(@view_context.link_to(@view_context.icon('plus-square', "New #{object_label}"),
                                         new_url,
                                         class: 'btn btn-success btn-sm',
                                         id: "new_#{downcased_object_class}_link"))
    end

    actions + additional_external_actions
  end

  def output_back_button?
    (action_name == 'new' || action_name == 'create') && !no_back_button
  end

  private

    def object_label_plural
      object_label.pluralize
    end

    def object_label
      klass.model_name.human.titleize
    end

    def include_edit_action?
      action_name == 'show' &&
        !no_edit_button &&
        instance&.persisted? &&
        current_user &&
        class_policy.update? &&
        instance_policy.update?
    end

    def edit_action
      @view_context.link_to(@view_context.icon(:pencil, 'Edit'), edit_url, class: 'btn btn-secondary btn-sm')
    end

    def include_duplicate_action?
      action_name == 'show' &&
        AppInfo.new.duplicates_enabled?(klass.name) &&
        instance.duplicate.present? &&
        instance.duplicate.score.present? &&
        instance_policy.resolve_duplicates?
    end

    def duplicate_action
      @view_context.link_to(@view_context.icon(:cubes, 'Fix Duplicates'),
                            @view_context.resolve_duplicates_path(model: instance.class, id: instance.id),
                            class: 'btn btn-warning btn-sm')
    end

    def include_duplicates_action?
      action_name == 'index' &&
        AppInfo.new.duplicates_enabled?(klass.name) &&
        class_policy.resolve_duplicates? &&
        klass.high_duplicates.size.positive?
    end

    def duplicates_action
      @view_context.link_to(@view_context.icon(:cubes, 'Fix Duplicates'),
                            @view_context.resolve_duplicates_path(model: klass),
                            class: 'btn btn-warning btn-sm')
    end

    def include_delete_action?
      action_name != 'index' &&
        !no_delete_button &&
        instance&.persisted? &&
        current_user &&
        class_policy.destroy? &&
        instance_policy.destroy?
    end

    def include_tools_button?
      tool_actions.any?
    end

    def tools_button
      @view_context.render 'layouts/card_tools_button', actions: tool_actions
    end

    def tool_actions
      @tool_actions ||= ([show_history_action] + contact_log_actions + [reset_duplicates_action]).compact
    end

    def show_history_action
      return unless @view_context.user_signed_in? &&
                    current_user.internal? &&
                    instance.present? &&
                    instance.class.name != 'ActiveStorage::Attachment' &&
                    instance.respond_to?(:audits) &&
                    instance.persisted? &&
                    instance_policy.audit?

      { label: 'Audit History',
        link: @view_context.audits_path(search: { single_record: "#{single_record_class_name}:#{instance.id}" }) }
    end

    def single_record_class_name
      return instance.class.to_s unless instance.class.to_s.start_with?('Notifications::')

      'NotificationType'
    end

    def contact_log_actions
      return [] unless action_name == 'show' &&
                       instance&.persisted? &&
                       current_user &&
                       Pundit.policy!(current_user, ContactLog.new).index? &&
                       contact_logs?

      return user_contact_log_actions if instance.is_a?(User)

      [{ label: 'Contact Logs', link: contact_log_record_action }]
    end

    def user_contact_log_actions
      [{ label: 'Contact Logs to User',
         link: @view_context.contact_logs_path(search: { 'contact_log_recipients.to_user_id': instance.id }) },
       { label: 'Contact Logs from User',
         link: @view_context.contact_logs_path(search: { 'contact_logs.from_user_id': instance.id }) },
       { label: 'Contact Logs w/ User as Subject', link: contact_log_record_action },
       { label: 'All Associated Contact Logs',
         link: @view_context.contact_logs_path(search: { associated_with_user: instance.id }) }]
    end

    def contact_log_record_action
      @view_context.contact_logs_path(search: { 'contact_logs.record_type': instance.class.name,
                                                record_id_equals: instance.id })
    end

    def contact_logs?
      # TODO: need to make sure these queries are very fast since it's gonna hit on every show action
      # return ContactLog.associated_with_user(instance.id).limit(1).exists? if instance.is_a?(User)
      return true if instance.is_a?(User) # TODO: temporary hack until query optimization is verified

      ContactLog.where(record: instance).limit(1).exists?
    end

    def reset_duplicates_action
      return unless @view_context.user_signed_in? &&
                    current_user.internal? &&
                    instance.present? &&
                    instance.respond_to?(:persisted?) &&
                    instance.persisted? &&
                    AppInfo.new.duplicates_enabled?(instance.class.name) &&
                    instance_policy.reset_duplicates?

      confirm_message = 'This will reset non-duplicates and regenerate possible matches for this record, proceed?'

      { label: 'Reset Duplicates',
        link: @view_context.reset_duplicates_path(model: instance.class, id: instance.id),
        method: :put,
        data: { confirm: confirm_message } }
    end

    def delete_action
      delete_button_content || @view_context.link_to(@view_context.icon(:times, 'Delete'),
                                                     instance,
                                                     method: :delete,
                                                     data: { confirm: delete_confirmation },
                                                     class: 'btn btn-danger btn-sm')
    end

    def show_index_button?
      return false if no_index_button
      return false unless %w[show edit update new create].include?(action_name)
      return false unless current_user && class_policy.index?
      return false if no_records?

      true
    end

    def no_records?
      Pundit.policy_scope!(current_user, klass).count.zero?
    end

    def class_policy
      @class_policy ||= Pundit.policy!(current_user, check_policy_klass)
    end

    def instance_policy
      @instance_policy ||= Pundit.policy!(current_user, check_policy_instance)
    end

    def check_policy_klass
      if current_user.external? && RadConfig.portal?
        [:portal, klass.new]
      else
        klass.new
      end
    end

    def check_policy_instance
      if current_user.external? && RadConfig.portal?
        [:portal, instance]
      else
        instance
      end
    end
end
