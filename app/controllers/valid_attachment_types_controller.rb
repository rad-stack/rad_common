class ValidAttachmentTypesController < ApplicationController
  def index
    skip_policy_scope
    skip_authorization

    render json: [RadCommon::VALID_ATTACHMENT_TYPES], status: :ok
  end
end
