module RadNav
  class TopNavIndexItem
    attr_accessor :view_context, :model_name, :path, :label

    delegate :policy, to: :view_context

    def initialize(view_context, model_name, path: nil, label: nil)
      @view_context = view_context
      @model_name = model_name
      @path = path
      @label = label
    end

    def content
      return unless policy(model_name.constantize).index?

      TopNavItem.new(view_context,
                     label.presence || model_name.titleize.pluralize,
                     path.presence || "/#{model_name.constantize.table_name}",
                     badge: duplicates_badge).content
    end

    private

      def duplicates_badge
        count = view_context.duplicates_badge_count(model_name)
        return if count.zero?

        NavBadge.new(view_context, :warning, count)
      end
  end
end
