module RadbearController
  extend ActiveSupport::Concern

  included do
    before_action :configure_devise_permitted_parameters, if: :devise_controller?
    before_action :set_raven_user_context
  end

  def validate_active_storage_attachment(record, attribute, file, valid_types)
    # TODO: Remove this method and all calls when active storage validations are added (expected in Rails 6)
    return true if file.blank?

    if !file.content_type.in?(valid_types)
      flash[:error] = "File could not be saved. File type must be one of #{valid_types.join(', ')}."
      render :edit
      false
    else
      record.send(attribute).attach(file)
      true
    end
  end

  protected

    def set_raven_user_context
      return unless current_user

      Raven.context.user = { user_id: current_user.id }
    end
end
