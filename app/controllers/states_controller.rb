class StatesController < ApplicationController
  before_action :set_state, only: %i[show edit update destroy]

  def index
    authorize State
    @states = policy_scope(State).sorted
  end

  def show; end

  def new
    @state = State.new
    authorize @state
  end

  def edit; end

  def create
    @state = State.new(permitted_params)
    authorize @state

    if @state.save
      redirect_to @state, notice: 'State was successfully created.'
    else
      render :new
    end
  end

  def update
    if @state.update(permitted_params)
      redirect_to @state, notice: 'State was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    destroyed = @state.destroy

    if destroyed
      flash[:success] = 'State was successfully deleted.'
    else
      flash[:error] = @state.errors.full_messages.join(', ')
    end

    index_paths = [state_path(@state), edit_state_path(@state)]

    if destroyed && index_paths.include?(URI(request.referer).path)
      redirect_to states_path
    else
      redirect_back(fallback_location: states_path)
    end
  end

  private

    def set_state
      @state = State.find(params[:id])
      authorize @state
    end

    def permitted_params
      params.require(:state).permit(:code, :name)
    end
end
