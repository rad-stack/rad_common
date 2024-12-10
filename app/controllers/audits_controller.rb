class AuditsController < ApplicationController
  def index
    if single_resource?
      @resource = params[:auditable_type].constantize.find(params[:auditable_id])
      authorize @resource, :audit?
      skip_policy_scope

      @audits = @resource.own_and_associated_audits.page(params[:page])
      @show_search = false
    else
      authorize RadAudit
      skip_policy_scope

      @audit_search = RadAuditSearch.new(params, current_user)
      @audits = @audit_search.results.page(params[:page])
      @show_search = true
    end
  end

  private

    def single_resource?
      params[:auditable_type].present? && params[:auditable_id].present?
    end
end
