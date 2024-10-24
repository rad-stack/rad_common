class AuditsController < ApplicationController
  def index
    authorize RadAudit
    skip_policy_scope

    @audit_search = RadAuditSearch.new(params, current_user)
    @audits = @audit_search.results.page(params[:page])
  end
end
