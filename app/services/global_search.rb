class GlobalSearch
  attr_accessor :current_user, :mode

  def initialize(current_user, mode)
    @current_user = current_user
    @mode = mode

    validate_mode
  end

  def filtered_scopes
    scopes.reject { |item| hide_scope?(item) }
  end

  def scopes
    raw_scopes = RadConfig.global_search_scopes!.select { |item| policy_ok?(item) }

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

    def validate_mode
      return if %i[global_search searchable_association].include?(mode)

      raise "Invalid mode: #{mode}"
    end

    def hide_scope?(scope)
      scope[:hide_global_nav] || no_records?(scope)
    end

    def no_records?(scope)
      Pundit.policy_scope!(current_user, scope[:model].constantize).none?
    end

    def policy_ok?(item)
      return false unless Pundit.policy!(current_user, item[:model].constantize).index?
      return true if searchable_association?

      Pundit.policy!(current_user, item[:model].constantize).show?
    end

    def searchable_association?
      mode == :searchable_association
    end
end
