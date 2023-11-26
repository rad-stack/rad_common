module RadNav
  class DropdownMenuIndexItem
    attr_accessor :view_context, :model_name, :path, :label, :badge

    delegate :policy, to: :view_context

    def initialize(view_context, model_name, path: nil, label: nil, badge: nil)
      @view_context = view_context
      @model_name = model_name
      @path = path
      @label = label
      @badge = badge
    end

    def content
      RadNav::DropdownMenuItem.new(view_context,
                                   label.presence || model_name.titleize.pluralize,
                                   path.presence || "/#{model_name.constantize.table_name}",
                                   permission: policy(model_name.constantize).index?,
                                   badge: badge_content).content
    end

    def badge_content
      if badge.present? && duplicates_badge.present?
        # need to figure out how to merge them if needed
        raise 'having a badge option when duplicates badge exists is not yet supported'
      end

      badge.presence || duplicates_badge
    end

    private

      def duplicates_badge
        RadNav::DuplicatesBadge.new(view_context, model_name).content
      end
  end
end
