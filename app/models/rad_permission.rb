class RadPermission
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def tooltip
    I18n.t "permission_tooltips.#{name}", default: permission_tooltip_default
  end

  private

    def permission_tooltip_default
      if name.start_with?('create_')
        suffix = name.gsub('create_', '').titleize.pluralize.downcase
        "Create new #{suffix}"
      elsif name.start_with?('read_')
        suffix = name.gsub('read_', '').titleize.pluralize.downcase
        "Read #{suffix}"
      elsif name.start_with?('update_')
        suffix = name.gsub('update_', '').titleize.pluralize.downcase
        "Update existing #{suffix}"
      elsif name.start_with?('edit_')
        suffix = name.gsub('edit_', '').titleize.pluralize.downcase
        "Update existing #{suffix}"
      elsif name.start_with?('destroy_')
        suffix = name.gsub('destroy_', '').titleize.pluralize.downcase
        "Delete #{suffix}"
      elsif name.start_with?('delete_')
        suffix = name.gsub('delete_', '').titleize.pluralize.downcase
        "Delete #{suffix}"
      elsif name.start_with?('manage_')
        suffix = name.gsub('manage_', '').titleize.pluralize.downcase
        "Manage (read/create/update/delete) #{suffix}"
      else
        ''
      end
    end

    def permission_tooltip_content
      return if permission_tooltip(name).blank?

      tag.i('',
            class: 'fa fa-question-circle custom-tooltip tooltip-pad mr-2',
            'data-toggle': 'tooltip',
            title: permission_tooltip(name))
    end
end
