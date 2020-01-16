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

  def object_class
    controller_name.classify.titleize
  end

  def object_label
    if controller_alias
      controller_alias.classify.titleize
    else
      object_class
    end
  end

  def downcased_object_class
    controller_name.classify.downcase
  end

  def titleized_controller_name
    if controller_alias
      controller_alias.titleize
    else
      controller_name.titleize
    end
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

  def controller_alias
    local_assigns[:controller_alias]
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
    '@' + (local_assigns[:instance_variable_name] || controller_name.classify.underscore)
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

  def output_title
    return title if title.present?
    return "New #{object_label}" if action_name == 'new' || action_name == 'create'
    return @output_title = "#{object_label}: #{instance_label}" if action_name == 'show'

    if action_name == 'index'
      the_var = controller.instance_variable_get('@' + controller_name)
      return "#{titleized_controller_name} (#{the_var.respond_to?(:total_count) ? the_var.total_count : the_var.count})"
    end

    if action_name == 'edit' || action_name == 'update'
      the_title = "Editing #{object_label}:"

      if no_show_link
        the_title += " #{instance_label}"
      else
        the_title += ' ' + @view_context.link_to(instance_label, instance)
        the_title = the_title.html_safe
      end

      return the_title
    end

    raise 'missing card header title'
  end

  def output_actions
    actions = []

    if action_name == 'show'
      if !no_edit_button && current_user && Pundit.policy!(current_user, check_policy_klass).update? && Pundit.policy!(current_user, check_policy_instance).update?
        actions.push(@view_context.link_to(@view_context.icon(:pencil, 'Edit'), edit_url, class: 'btn btn-secondary btn-sm'))
      end
    end

    actions += additional_actions

    if !no_delete_button && instance && instance.id && current_user && Pundit.policy!(current_user, check_policy_klass).destroy? && Pundit.policy!(current_user, check_policy_instance).destroy?
      if delete_button_content
        actions.push(delete_button_content)
      else
        actions.push(@view_context.link_to(@view_context.icon(:times, 'Delete'), instance, method: :delete, data: { confirm: delete_confirmation }, class: 'btn btn-danger btn-sm'))
      end
    end

    actions
  end

  def output_external_actions
    actions = []

    actions += external_actions

    if action_name == 'edit' || action_name == 'update' || action_name == 'show'
      if !no_new_button && current_user && Pundit.policy!(current_user, check_policy_klass).new?
        actions.push(@view_context.link_to(@view_context.icon('plus-square', "Add Another #{object_label}"), new_url, class: 'btn btn-success btn-sm', id: "new_#{downcased_object_class}_link"))
      end
    end

    if !no_index_button && %w[show edit update new create].include?(action_name)
      if current_user && Pundit.policy!(current_user, check_policy_klass).index?
        actions.push(@view_context.link_to(@view_context.icon(:list, 'View ' + titleized_controller_name), index_path, class: 'btn btn-secondary btn-sm'))
      end
    end

    if action_name == 'index'
      if !no_new_button && current_user && Pundit.policy!(current_user, check_policy_klass).new?
        actions.push(@view_context.link_to(@view_context.icon('plus-square', "New #{object_label}"), new_url, class: 'btn btn-success btn-sm', id: "new_#{downcased_object_class}_link"))
      end
    end

    actions += additional_external_actions

    actions
  end

  def output_back_button?
    (action_name == 'new' || action_name == 'create') && !no_back_button
  end

  private

    def check_policy_klass
      if current_user.portal?
        [Rails.application.config.portal_namespace, klass.new]
      else
        klass.new
      end
    end

    def check_policy_instance
      if current_user.portal?
        [Rails.application.config.portal_namespace, instance]
      else
        instance
      end
    end
end
