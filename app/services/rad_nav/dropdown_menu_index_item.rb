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
        # TODO: refactor this with the other one
        # TODO: cache it
        return unless RadCommon::AppInfo.new.duplicates_enabled?(model_name) && policy(model_name.constantize.new).index_duplicates?

        count = model_name.constantize.high_duplicates.count
        return if count.zero?

        RadNav::NavBadge.new(view_context, :warning, count)
      end
  end
end
