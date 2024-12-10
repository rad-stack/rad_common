class GlobalValidationsController < ApplicationController
  def new
    authorize GlobalValidation
  end

  def create
    authorize GlobalValidation

    GlobalValidationJob.perform_later(current_user, single_model)

    flash[:success] = "We're checking the validity of your company's data. You will get an email with " \
                      'the results. This may take a while.'

    redirect_to '/rad_common/global_validations/new'
  end

  private

    def single_model
      return if params[:single_model].blank?

      params[:single_model].to_s
    end
end
