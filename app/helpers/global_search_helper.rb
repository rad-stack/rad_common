module GlobalSearchHelper
  def global_search_scopes
    raw_scopes = RadicalConfig.global_search_scopes!
    raw_scopes = raw_scopes.select { |item| item[:show_in_portal] } if current_user.portal?

    raw_scopes = raw_scopes.select do |item|
      policy(GlobalAutocomplete.check_policy_klass(current_user, item[:model].constantize)).index?
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
end
