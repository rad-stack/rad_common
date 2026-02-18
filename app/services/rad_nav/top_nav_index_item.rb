module RadNav
  class TopNavIndexItem
    attr_accessor :view_context, :model_name, :path, :label, :icon_name

    delegate :policy, to: :view_context

    def initialize(view_context, model_name, path: nil, label: nil, icon_name: nil)
      @view_context = view_context
      @model_name = model_name
      @path = path
      @label = label
      @icon_name = icon_name
    end

    def content
      return unless policy(model_name.constantize).index?

      TopNavItem.new(view_context,
                     label.presence || model_name.titleize.pluralize,
                     path.presence || "/#{model_name.constantize.table_name}",
                     badge: duplicates_badge,
                     icon_name: icon_name || default_icon).content
    end

    private

      def duplicates_badge
        count = view_context.duplicates_badge_count(model_name)
        return if count.zero?

        NavBadge.new(view_context, :warning, count)
      end

      def default_icon
        'users'
      end
  end
end
