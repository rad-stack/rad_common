module RadNav
  class DropdownMenuIndexItem
    attr_accessor :view_context, :model_name, :path, :label, :badge

    delegate :policy, to: :view_context

    def initialize(view_context, model_name, path: nil, label: nil, badge: nil)
      @view_context = view_context
      @model_name = model_name
      @path = path
      @label = label

      if badge.present? && duplicates_badge.present?
        # need to figure out how to merge them if needed
        raise 'having a badge option when duplicates badge exists is not yet supported'
      elsif badge.present?
        @badge = badge
      elsif duplicates_badge.present?
        @badge = duplicates_badge
      end
    end

    def content
      RadNav::DropdownMenuItem.new(view_context,
                                   label.presence || model_name.titleize.pluralize,
                                   path.presence || "/#{model_name.constantize.table_name}",
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

        RadNav::NavBadge.new(view_context, :warning, count)
      end
  end
end
