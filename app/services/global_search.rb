class GlobalSearch
  attr_accessor :current_user, :mode

  def initialize(current_user, mode)
    @current_user = current_user
    @mode = mode
  end

  def filtered_scopes
    scopes.reject { |item| hide_scope?(item) }
  end

  def scopes
    raw_scopes = RadConfig.global_search_scopes!
    raw_scopes = raw_scopes.select { |item| item[:show_in_portal] } if current_user.external?
    raw_scopes = raw_scopes.select { |item| policy_ok?(item) }

    if current_user.global_search_default.blank?
      scopes = raw_scopes
    else
      top = raw_scopes.select { |item| item[:name] == current_user.global_search_default }

      if top.any?
        scopes = top
        raw_scopes.reject! { |item| item[:name] == current_user.global_search_default }
        scopes += raw_scopes
      else
        scopes = raw_scopes
      end
    end

    scopes
  end

  private

    def hide_scope?(scope)
      scope[:hide_global_nav] || no_records?(scope)
    end

    def no_records?(scope)
      Pundit.policy_scope!(current_user, scope[:model].constantize).none?
    end

    def policy_ok?(item)
      if mode == :global_search
        Pundit.policy!(current_user, check_policy_klass(item)).global_search?
      elsif mode == :searchable_association
        Pundit.policy!(current_user, check_policy_klass(item)).searchable_association?
      else
        raise "invalid mode: #{mode}"
      end
    end

    def check_policy_klass(item)
      if current_user.external? && RadConfig.portal?
        [:portal, item[:model].constantize.new]
      else
        item[:model].constantize.new
      end
    end
end
