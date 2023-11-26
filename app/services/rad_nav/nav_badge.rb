module RadNav
  class NavBadge
    attr_accessor :view_context, :alert_style, :count

    delegate :tag, to: :view_context

    def initialize(view_context, alert_style, count)
      @view_context = view_context
      @alert_style = alert_style
      @count = count
    end

    def content
      return if count.zero?

      tag.span(class: "badge alert-#{alert_style}") do
        count.to_s
      end
    end
  end
end
