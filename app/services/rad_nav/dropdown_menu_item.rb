module RadNav
  class DropdownMenuItem
    attr_accessor :view_context, :label, :path, :permission, :badge, :link_options

    delegate :tag, :link_to, :safe_join, to: :view_context

    def initialize(view_context, label, path, badge: nil, link_options: {}, permission: true)
      @view_context = view_context
      @label = label
      @path = path
      @permission = permission
      @badge = badge
      @link_options = link_options
    end

    def content
      return unless permission

      tag.li do
        link_to path, { class: 'dropdown-item' }.merge(link_options) do
          badge.present? ? safe_join([label, ' ', badge.content].compact) : label
        end
      end
    end
  end
end
