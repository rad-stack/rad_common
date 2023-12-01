module RadNav
  class DropdownMenuIndexItem
    attr_accessor :view_context, :model_name, :path, :label, :badge

    delegate :policy, to: :view_context

    def initialize(view_context, model_name, path: nil, label: nil, badge: nil)
      @view_context = view_context
      @model_name = model_name
      @path = path.presence || "/#{model_name.constantize.table_name}"
      @label = label.presence || model_name.titleize.pluralize

      if badge.present? && duplicates_badge.present?
        @badge = NavBadge.new(view_context,
                              NavBadge.highest_alert_style([badge, duplicates_badge]),
                              badge.count + duplicates_badge.count)
      elsif badge.present?
        @badge = badge
      elsif duplicates_badge.present?
        @badge = duplicates_badge
      end
    end

    def content
      DropdownMenuItem.new(view_context,
                           label,
                           path,
                           permission: policy(model_name.constantize).index?,
                           badge: badge).content
    end

    private

      def duplicates_badge
        @duplicates_badge ||= calc_duplicates_badge
      end

      def calc_duplicates_badge
        count = view_context.duplicates_badge_count(model_name)
        return if count.zero?

        NavBadge.new(view_context, :warning, count)
      end
  end
end
