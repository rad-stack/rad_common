class AttachmentValidationsController < ApplicationController
  def index
    skip_policy_scope
    skip_authorization

    errors = attachment_validation_errors(params[:content_type], params[:size].to_i)
    render json: { success: errors.empty?, errors: errors }, status: :ok
  end
end
