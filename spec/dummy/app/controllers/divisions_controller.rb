class DivisionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_division, only: %i[show edit update destroy audit]

  authorize_actions_for Division
  authority_actions audit: 'audit'

  def index
    @divisions = Division.all.page(params[:page])
  end

  def show; end

  def new
    @division = Division.new
  end

  def edit; end

  def create
    @division = Division.new(permitted_params)
    @division.owner = current_user

    if @division.save
      redirect_to @division, notice: 'Division was successfully created.'
    else
      render :new
    end
  end

  def update
    if @division.update(permitted_params)
      redirect_to @division, notice: 'Division was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    destroyed = @division.destroy

    if destroyed
      flash[:success] = 'Division was successfully deleted.'
    else
      flash[:error] = @division.errors.full_messages.join(', ')
    end

    if destroyed && (URI(request.referer).path == division_path(@division)) || (URI(request.referer).path == edit_division_path(@division))
      redirect_to divisions_path
    else
      redirect_back(fallback_location: divisions_path)
    end
  end

  private

    def set_division
      @division = Division.find(params[:id])
    end

    def permitted_params
      params.require(:division).permit(:name, :code)
    end
end
