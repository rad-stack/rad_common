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

      RadNav::TopNavItem.new(view_context,
                             label.presence || model_name.titleize.pluralize,
                             path.presence || "/#{model_name.constantize.table_name}",
                             badge: duplicates_badge).content
    end

    private

      def duplicates_badge
        # TODO: refactor this with the other one
        return unless RadCommon::AppInfo.new.duplicates_enabled?(model_name) && policy(model_name.constantize.new).index_duplicates?

        count = model_name.constantize.high_duplicates.count
        return if count.zero?

        RadNav::NavBadge.new(view_context, :warning, count)
      end
  end
end
