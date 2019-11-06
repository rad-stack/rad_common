module RadbearAuditsController
  extend ActiveSupport::Concern

  def audit
    the_instance = instance_variable_get('@' + controller_name.classify.underscore)
    show_audits the_instance
  end

  def audit_by
    @model_object = @user
    @audits = @model_object.audits_created(current_user)
    @audits = @audits.page(params[:page])

    render 'audits/index'
  end

  def audit_search
    authorize User
    resource_type = params['model_name']
    resource_id = params['record_id']
    system_audits = params['system_audits']

    return unless (resource_type.present? && resource_id.present?) || system_audits.present?

    if resource_type.present? && resource_id.present?
      audits = Audited::Audit.where(auditable_type: resource_type, auditable_id: resource_id)
      audit = audits.first

      if audit
        show_audits_for_type(resource_type, resource_id)
      else
        flash[:error] = "Audit for #{resource_type} with ID of #{resource_id} not found"
      end
    else
      show_system_audits resource_type
    end
  end

  private

    def show_audits_for_type(resource_type, resource_id)
      resource = resource_type.constantize.find_by(id: resource_id)
      resource ? show_audits(resource) : show_audits_for_deleted(resource_type, resource_id)
    end

    def show_audits_for_deleted(resource_type, resource_id)
      audits = Audited::Audit.where(auditable_type: resource_type, auditable_id: resource_id)

      @deleted = "#{resource_type} - #{resource_id}"
      @audits = audits.reorder('created_at DESC').page(params[:page])
      render 'audits/index'
    end

    def show_audits(resource)
      raise 'Unauthorized' unless current_user.can_audit?(resource) # controllers and UI should prevent coming here

      @model_object = resource
      @audits = @model_object.own_and_associated_audits
      @audits = @audits.reorder('created_at DESC').page(params[:page])
      render 'audits/index'
    end

    def show_system_audits(resource_type)
      raise 'Unauthorized' unless current_user.can_audit?(Company) # controllers and UI should prevent coming here

      @audits = Audited::Audit.where(user_id: nil)
      @audits = @audits.where(auditable_type: resource_type) if resource_type.present?
      @audits = @audits.order('created_at DESC').page(params[:page])
      render 'audits/index'
    end
end
