class UserClientsController < ApplicationController
  before_action :set_user_client, only: :destroy

  def new
    @user = User.find(params[:user_id])
    @user_client = UserClient.new
    @user_client.user = @user
    authorize @user_client
  end

  def create
    @user = User.find(params[:user_client][:user_id])
    @user_client = UserClient.new(permitted_params)
    @user_client.user = @user
    authorize @user_client

    if @user_client.save
      redirect_to @user_client.user, notice: "#{AppInfo.new.client_model_label} was successfully added."
    else
      render :new
    end
  end

  def destroy
    user = @user_client.user

    if @user_client.destroy
      flash[:notice] = "#{AppInfo.new.client_model_label} was successfully deleted."
    else
      flash[:error] = @user_client.errors.full_messages.join(', ')
    end

    redirect_to user
  end

  private

    def set_user_client
      @user_client = UserClient.find(params[:id])
      authorize @user_client
    end

    def permitted_params
      params.require(:user_client).permit(:client_id)
    end
end
