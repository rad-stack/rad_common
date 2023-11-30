module RadNav
  class TopNavItem
    attr_accessor :view_context, :label, :path, :badge

    delegate :tag, :link_to, :safe_join, to: :view_context

    def initialize(view_context, label, path, badge: nil)
      @view_context = view_context
      @label = label
      @path = path
      @badge = badge
    end

    def content
      tag.li do
        link_to path, class: 'nav-link px-2' do
          badge.present? ? safe_join([label, ' ', badge.content].compact) : label
        end
      end
    end
  end
end
