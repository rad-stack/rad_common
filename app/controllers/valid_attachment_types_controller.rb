class ValidAttachmentTypesController < ApplicationController
  def index
    skip_policy_scope
    skip_authorization

    errors = []
    unless RadCommon::VALID_ATTACHMENT_TYPES.include?(params[:content_type])
      errors << "Invalid attachment type #{params[:content_type]}"
    end

    errors << 'Invalid attachment, must be 100 MB or less' if bytes_to_megabytes(params[:size].to_i) > 100

    render json: { success: errors.empty?, errors: errors }, status: :ok
  end

  private

    def bytes_to_megabytes(bytes)
      bytes.to_f / (1024 * 1024)
    end
end
