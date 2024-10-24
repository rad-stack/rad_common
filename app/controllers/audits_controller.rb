class AuditsController < ApplicationController
  def index
    @audit_search = RadAuditSearch.new(params, current_user)
    @audits = policy_scope(@audit_search.results).page(params[:page])

    if @audit_search.single_record?
      authorize @audit_search.single_record, :audit?
    else
      authorize RadAudit
    end
  end
end
