module RadbearAuditsController
  extend ActiveSupport::Concern

  def audit
    the_instance = instance_variable_get('@' + controller_name.classify.underscore)
    show_audits the_instance
  end

  def audit_by
    @model_object = @member
    @audits = @model_object.audits_created(current_member)

    if current_member.respond_to?(:company_id)
      @audits = @audits.where(associated_id: current_member.company_id)
    end

    @audits = @audits.page(params[:page])

    render 'audits/index'
  end

  def audit_search
    resource_type = params['model_name']
    resource_id = params['record_id']

    @models = ActiveRecord::Base.connection.tables.sort.map { |model| model.capitalize.singularize.humanize }

    return unless resource_type.present? && resource_id.present?

    audits = Audited::Audit.where(auditable_type: resource_type.parameterize(separator: '_').camelize, auditable_id: resource_id)
    audits = audits.where(associated_id: current_member.company_id) if current_member.respond_to?(:company_id)
    audit = audits.first
    audit ? show_audits_for_type(resource_type, resource_id) : flash[:error] = "Audit for #{resource_type} with ID of #{resource_id} not found"
  end

  private

    def show_audits_for_type(resource_type, resource_id)
      resource = resource_type.parameterize(separator: '_').camelize.constantize.find_by(id: resource_id)
      resource ? show_audits(resource) : show_audits_for_deleted(resource_type, resource_id)
    end

    def show_audits_for_deleted(resource_type, resource_id)
      audits = Audited::Audit.where(auditable_type: resource_type.parameterize(separator: '_').camelize, auditable_id: resource_id)
      audits = audits.where(associated_id: current_member.company_id) if current_member.respond_to?(:company_id)

      @deleted = "#{resource_type} - #{resource_id}"
      @audits = audits.reorder('created_at DESC').page(params[:page])
      render 'audits/index'
    end

    def show_audits(resource)
      raise 'Unauthorized' unless current_member.can_audit?(resource) # controllers and UI should prevent coming here

      @model_object = resource
      @audits = @model_object.audits

      if current_member.respond_to?(:company_id)
        @audits = @audits.where(associated_id: current_member.company_id)
      end

      @audits = @audits.reorder('created_at DESC').page(params[:page])
      render 'audits/index'
    end
end
