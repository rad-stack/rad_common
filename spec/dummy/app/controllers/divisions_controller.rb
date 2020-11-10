class DivisionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_division, only: %i[show edit update destroy]

  def index
    authorize Division
    skip_policy_scope

    filters = [{ input_label: 'Owner', column: :owner_id, default_value: current_user.id,
                 options: [['Active', User.active.by_name],
                           ['Inactive', User.inactive.by_name]],
                 grouped: true },
               { input_label: 'Status', column: :division_status,
                 options: ApplicationController.helpers.db_options_for_enum(Division, :division_status) },
               { column: :name, type: RadCommon::LikeFilter },
               { column: :created_at, type: RadCommon::DateFilter,
                 start_input_label: 'Division Created At Start',
                 end_input_label: 'Division Created At End',
                 default_start_value: Date.current, default_end_value: Date.current }]

    @division_search = RadCommon::Search.new(query: Division.sorted,
                                             filters: filters,
                                             current_user: current_user,
                                             search_name: 'divisions_search',
                                             sticky_filters: true,
                                             params: params)

    @divisions = @division_search.results.page(params[:page])
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
      if validate_active_storage_attachment(@division, 'icon', params['division']['icon'], ['image/png'], false, 50_000)
        redirect_to @division, notice: 'Division was successfully created.'
      end
    else
      render :new
    end
  end

  def update
    if @division.update(permitted_params)
      if validate_multiple_attachments(@division, :division, division_attachments_and_types)
        redirect_to @division, notice: 'Division was successfully updated.'
      end
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
      authorize @division
    end

    def permitted_params
      params.require(:division).permit(:name, :code, :notify, :timezone, :owner_id, :hourly_rate, :division_status)
    end

    def division_attachments_and_types
      [{ attr: :logo, types: ['image/png'] },
       { attr: :avatar, types: ['image/jpeg'] },
       { attr: :attachment, types: %w[image/jpeg text/plain application/pdf] }]
    end
end
