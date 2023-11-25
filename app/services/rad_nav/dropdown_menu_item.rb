module RadNav
  class DropdownMenuItem
    attr_accessor :view_context, :label, :path, :permission, :badge, :separate_tab

    delegate :tag, :link_to, :safe_join, to: :view_context

    def initialize(view_context, label, path, badge: nil, separate_tab: false, permission: true)
      @view_context = view_context
      @label = label
      @path = path
      @permission = permission
      @badge = badge
      @separate_tab = separate_tab
    end

    def content
      return unless permission

      tag.li do
        link_to path, link_options do
          badge.present? ? safe_join([label, ' ', badge].compact) : label
        end
      end
    end

    private

      def link_options
        items = { class: 'dropdown-item' }
        items = items.merge(target: '_blank', rel: :noopener) if separate_tab?
        items
      end

      def separate_tab?
        separate_tab
      end
  end
end
