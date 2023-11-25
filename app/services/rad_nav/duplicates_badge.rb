module RadNav
  class DuplicatesBadge
    attr_accessor :view_context, :model_name, :klass

    delegate :policy, :tag, to: :view_context

    def initialize(view_context, model_name)
      @view_context = view_context
      @model_name = model_name
      @klass = model_name.constantize
    end

    def content
      return unless RadCommon::AppInfo.new.duplicates_enabled?(model_name) && policy(klass.new).index_duplicates?

      count = klass.high_duplicates.count
      return unless count.positive?

      RadNav::NavBadge.new(view_context, :warning, count).content
    end
  end
end
