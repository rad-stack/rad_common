module RadNav
  class DropdownMenuItem
    attr_accessor :view_context, :label, :path, :permission

    delegate :tag, :link_to, to: :view_context

    def initialize(view_context, label, path, permission: true)
      @view_context = view_context
      @label = label
      @path = path
      @permission = permission
    end

    def content
      return unless permission

      tag.li do
        link_to label, path, class: 'dropdown-item'
      end
    end
  end
end
