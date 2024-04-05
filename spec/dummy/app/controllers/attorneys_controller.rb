class AttorneysController < ApplicationController
  before_action :set_attorney, only: %i[show edit update destroy]

  def index
    authorize Attorney
    @attorneys = policy_scope(Attorney).by_name.page(params[:page])
  end

  def show
    respond_to do |format|
      format.html
      format.pdf { render pdf: @attorney.to_s }
    end
  end

  def new
    @attorney = Attorney.new
    authorize @attorney
  end

  def edit; end

  def create
    @attorney = Attorney.new(permitted_params)
    authorize @attorney

    if @attorney.save
      redirect_to @attorney, notice: 'Attorney was successfully created.'
    else
      render :new
    end
  end

  def update
    if @attorney.update(permitted_params)
      redirect_to @attorney, notice: 'Attorney was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    destroyed = @attorney.destroy

    if destroyed
      flash[:success] = 'Attorney was successfully deleted.'
    else
      flash[:error] = @attorney.errors.full_messages.join(', ')
    end

    if (destroyed &&
       (URI(request.referer).path == attorney_path(@attorney))) ||
       (URI(request.referer).path == edit_attorney_path(@attorney))
      redirect_to attorneys_path
    else
      redirect_back(fallback_location: attorneys_path)
    end
  end

  private

    def set_attorney
      @attorney = Attorney.find(params[:id])
      authorize @attorney
    end

    def permitted_params
      params.require(:attorney).permit(:first_name, :last_name, :middle_name, :company_name, :mobile_phone,
                                       :phone_number, :email, :address_1, :address_2, :city, :state, :zipcode, :active)
    end
end
