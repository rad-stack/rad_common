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

      tag.span(class: "badge bg-#{alert_style} bg-opacity-75") do
        count.to_s
      end
    end

    def self.highest_alert_style(badges)
      styles = badges.map(&:alert_style).uniq.sort
      return styles.first if styles.count == 1
      return :warning if styles == %i[info warning]
      return :danger if styles == %i[danger info warning]
      return :danger if styles == %i[danger info]

      # just need to handle any additional combinations that occur, choose the higher alert level
      raise "conflicting badge styles: #{styles}"
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
