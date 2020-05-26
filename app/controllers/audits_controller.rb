class AuditsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:auditable_type].present? && params[:auditable_id].present?
      @resource = params[:auditable_type].constantize.find(params[:auditable_id])
      authorize @resource, :audit?
      skip_policy_scope

      @audits = @resource.own_and_associated_audits
      @audits = @audits.reorder('created_at DESC').page(params[:page])
      @show_search = false
    else
      authorize RadAudit
      skip_policy_scope

      @audit_search = RadAuditSearch.new(params, current_user)
      @audits = @audit_search.results.page(params[:page])
      @show_search = true
    end
  end
end
