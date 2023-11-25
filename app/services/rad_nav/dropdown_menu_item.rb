module RadNav
  class DropdownMenuItem
    attr_accessor :view_context, :label, :path, :permission, :badge

    delegate :tag, :link_to, :safe_join, to: :view_context

    def initialize(view_context, label, path, badge: nil, permission: true)
      @view_context = view_context
      @label = label
      @path = path
      @permission = permission
      @badge = badge
    end

    def content
      return unless permission

      tag.li do
        link_to path, class: 'dropdown-item' do
          badge.present? ? safe_join([label, ' ', badge].compact) : label
        end
      end
    end
  end
end
