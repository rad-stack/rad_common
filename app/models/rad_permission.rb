class RadPermission
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def label
    name.titleize
  end

  def short_label(category_name)
    return label if label == category_name

    label.gsub(category_name, '').strip
  end

  def tooltip?
    tooltip.present?
  end

  def tooltip
    I18n.t "permission_tooltips.#{name}", default: permission_tooltip_default
  end

  def security_roles
    SecurityRole.where("#{name} = TRUE").by_name
  end

  def users
    User.active.by_permission(name).by_name
  end

  class << self
    def all
      (SecurityRole.attribute_names - %w[id name created_at updated_at external allow_invite allow_sign_up]).sort
    end

    def exists?(permission_name)
      all.include? permission_name.to_s
    end

    def security_role_categories(security_role)
      # would be good to refactor this with user_categories

      items = RadCommon::AppInfo.new.application_models.map(&:underscore)

      categories = all.map do |item|
        permission = RadPermission.new(item)
        category_name = permission_category_name(items, item)

        { category_name: category_name,
          permission_label: permission.short_label(category_name),
          permission: permission.name,
          tooltip: permission.tooltip,
          value: security_role.send(item) }
      end

      categories.group_by { |item| item[:category_name] }.sort_by(&:first)
    end

    def user_categories(user)
      # would be good to refactor this with security_role_categories

      items = RadCommon::AppInfo.new.application_models.map(&:underscore)

      categories = all.map do |item|
        permission = RadPermission.new(item)
        category_name = permission_category_name(items, item)

        { category_name: category_name,
          permission_label: permission.short_label(category_name),
          permission: permission.name,
          tooltip: permission.tooltip,
          value: user.permission?(item) }
      end

      categories.group_by { |item| item[:category_name] }.sort_by(&:first)
    end

    private

      def permission_category_name(model_category_names, permission_name)
        return 'Admin' if permission_name == 'admin'

        model_category_names.each do |category|
          return category.titleize if permission_name.end_with?(category)
        end

        'Other'
      end
  end

  private

    def permission_tooltip_default
      [['create', 'Create new'],
       %w[read Read],
       ['update', 'Update existing'],
       ['edit', 'Update existing'],
       %w[destroy Delete],
       %w[delete Delete],
       ['manage', 'Manage (read/create/update/delete)']].each do |item|
        if name.start_with?("#{item.first}_")
          suffix = name.gsub("#{item.first}_", '').titleize.pluralize.downcase
          return "#{item.last} #{suffix}"
        end
      end

      ''
    end
end
