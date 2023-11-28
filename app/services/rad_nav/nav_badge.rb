module RadNav
  class NavBadge
    attr_accessor :view_context, :alert_style, :count

    delegate :tag, to: :view_context

    def initialize(view_context, alert_style, count)
      @view_context = view_context
      @alert_style = alert_style
      @count = count

      check_alert_style
    end

    def content
      return if count.zero?

      tag.span(class: "badge alert-#{alert_style}") do
        count.to_s
      end
    end

    private

      def check_alert_style
        raise 'alert_style must be a symbol' unless alert_style.is_a?(Symbol)
        raise 'alert style is invalid' unless alert_styles.include?(alert_style)
      end

      def alert_styles
        %i[primary secondary success danger warning info light dark]
      end
  end
end
