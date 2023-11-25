module RadNav
  class DropdownMenuIndexItem
    attr_accessor :view_context, :model_name, :path, :label

    delegate :policy, to: :view_context

    def initialize(view_context, model_name, path: nil, label: nil)
      @view_context = view_context
      @model_name = model_name
      @path = path
      @label = label
    end

    def content
      RadNav::DropdownMenuItem.new(view_context,
                                   label.presence || model_name.titleize.pluralize,
                                   path.presence || "/#{model_name.constantize.table_name}",
                                   permission: policy(model_name.constantize).index?,
                                   badge: RadNav::DuplicatesBadge.new(view_context, model_name).content).content
    end
  end
end
