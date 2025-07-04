class DivisionsController < ApplicationController
  before_action :set_division, only: %i[show edit update destroy]

  def index
    authorize Division

    @division_search = DivisionSearch.new(params, current_user)
    @divisions = policy_scope(@division_search.results).page(params[:page])
  end

  def show; end

  def new
    @division = Division.new
    authorize @division
  end

  def edit; end

  def create
    @division = Division.new(permitted_params)
    authorize @division

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
      flash[:notice] = 'Division was successfully deleted.'
    else
      flash[:error] = @division.errors.full_messages.join(', ')
    end

    if (destroyed && (URI(request.referer).path == division_path(@division))) ||
       (URI(request.referer).path == edit_division_path(@division))
      redirect_to divisions_path
    else
      redirect_back(fallback_location: divisions_path)
    end
  end

  def calendar
    authorize Division

    @divisions = Division.all

    respond_to do |format|
      format.html
      format.json do
        events = @divisions.map do |division|
          start_time = rand(1.month.ago.beginning_of_day..1.month.from_now.end_of_day).change(hour: rand(7..18))
          {
            title: division.to_s,
            description: division.additional_info,
            start: start_time,
            end: start_time + 1.hour
          }
        end
        render json: events
      end
    end
  end

  private

    def set_division
      @division = Division.find(params[:id])
      authorize @division
    end

    def permitted_params
      params.require(:division).permit(:name, :code, :notify, :timezone, :owner_id, :hourly_rate, :division_status,
                                       :icon, :logo, :category_id, :category_name, tags: [])
    end
end
