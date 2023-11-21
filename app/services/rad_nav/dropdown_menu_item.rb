module RadNav
  class DropdownMenuItem
    attr_accessor :view_context, :label, :path

    delegate :tag, :link_to, to: :view_context

    def initialize(view_context, label, path)
      @view_context = view_context
      @label = label
      @path = path
    end

    def content
      tag.li do
        link_to label, path, class: 'dropdown-item'
      end
    end
  end
end
