class ClientsController < ApplicationController
  before_action :set_client, only: %i[show edit update destroy]

  def index
    authorize Client
    @clients = policy_scope(Client).sorted.page(params[:page])
  end

  def show; end

  def new
    @client = Client.new
    authorize @client
  end

  def edit; end

  def create
    @client = Client.new(permitted_params)
    authorize @client

    if @client.save
      redirect_to @client, notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  def update
    if @client.update(permitted_params)
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    destroyed = @client.destroy

    if destroyed
      flash[:success] = 'Client was successfully deleted.'
    else
      flash[:error] = @client.errors.full_messages.join(', ')
    end

    index_paths = [client_path(@client), edit_client_path(@client)]

    if destroyed && index_paths.include?(URI(request.referer).path)
      redirect_to clients_path
    else
      redirect_back(fallback_location: clients_path)
    end
  end

  private

    def set_client
      @client = Client.find(params[:id])
      authorize @client
    end

    def permitted_params
      params.require(:client).permit(:name, :email, :active)
    end
end
