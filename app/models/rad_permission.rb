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
    SecurityRole.where("#{name} = TRUE").sorted
  end

  def users
    User.active.by_permission(name).sorted
  end

  def unused_no_users?
    return false if name == 'admin'

    where_clause = 'users.id NOT IN (SELECT user_security_roles.user_id FROM user_security_roles ' \
                   'WHERE user_security_roles.security_role_id = ?)'

    User.active.where(where_clause, SecurityRole.admin_role.id).by_permission(name).count < 1
  end

  def unused_all_users?
    return false if name == 'admin'

    users.count == User.active.count
  end

  class << self
    def all
      (SecurityRole.attribute_names -
        %w[id name created_at updated_at external allow_invite allow_sign_up two_factor_auth]).sort
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

    def unused_no_users
      RadPermission.all.select { |item| RadPermission.new(item).unused_no_users? }
    end

    def unused_all_users
      RadPermission.all.select { |item| RadPermission.new(item).unused_all_users? }
    end

    private

      def permission_category_name(model_category_names, permission_name)
        return 'Admin' if permission_name == 'admin'

        model_category_names.sort_by(&:size).reverse.each do |category|
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
