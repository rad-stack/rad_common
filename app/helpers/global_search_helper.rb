module GlobalSearchHelper
  def global_search_scopes
    raw_scopes = Rails.application.config.global_search_scopes
    raw_scopes = raw_scopes.reject { |item| !current_user.can_read?(item[:model].constantize) }

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
