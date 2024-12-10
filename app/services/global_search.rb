class GlobalSearch
  attr_accessor :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def filtered_scopes
    scopes.reject { |item| hide_scope?(item) }
  end

  def scopes
    raw_scopes = RadConfig.global_search_scopes!
    raw_scopes = raw_scopes.select { |item| item[:show_in_portal] } if current_user.portal?

    raw_scopes = raw_scopes.select do |item|
      Pundit.policy!(current_user,
                     GlobalAutocomplete.check_policy_klass(current_user, item[:model].constantize)).global_search?
    end

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
end
