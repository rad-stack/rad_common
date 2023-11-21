module RadNav
  class TopNavIndexItem
    attr_accessor :view_context, :model_name, :path, :badge, :label

    delegate :policy, to: :view_context

    def initialize(view_context, model_name, path: nil, badge: nil, label: nil)
      @view_context = view_context
      @model_name = model_name
      @path = path
      @badge = badge
      @label = label
    end

    def content
      return unless policy(model_name.constantize).index?

      RadNav::TopNavItem.new(view_context,
                             label.presence || model_name.titleize.pluralize,
                             path.presence || "/#{model_name.constantize.table_name}",
                             badge: badge).content
    end
  end
end
