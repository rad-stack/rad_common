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
                                   badge: this_badge).content
    end

    private

      def this_badge
        if badge.present? && duplicates_badge.present?
          # need to figure out how to merge them if needed
          raise 'having a badge option when duplicates badge exists is not yet supported'
        elsif badge.present?
          badge
        elsif duplicates_badge.present?
          duplicates_badge
        else
          nil
        end
      end

      def duplicates_badge
        # TODO: refactor this with the other one
        return unless RadCommon::AppInfo.new.duplicates_enabled?(model_name) && policy(model_name.constantize.new).index_duplicates?

        count = model_name.constantize.high_duplicates.count
        return if count.zero?

        RadNav::NavBadge.new(view_context, :warning, count)
      end
  end
end
