class PanelPresenter
  attr_reader :local_assigns

  def initialize(view_context, local_assigns = nil)
    @view_context = view_context
    @local_assigns = local_assigns
  end

  def _h
    @view_context
  end

  def params
    _h.params
  end

  def controller
    _h.controller
  end

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
    controller.instance_variable_get(instance_variable_name) if !custom?
  end

  def instance_label
    instance.to_s unless custom?
  end

  def klass
    Object.const_get(controller_name.classify) if !custom?
  end

  def custom?
    action_name == 'custom'
  end

  def title
    local_assigns[:title]
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
    "@" + (local_assigns[:instance_variable_name] || controller_name.classify.underscore)
  end

  def delete_confirmation
    local_assigns[:delete_confirmation] || 'Are you sure?'
  end
end
