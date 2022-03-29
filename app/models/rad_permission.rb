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
