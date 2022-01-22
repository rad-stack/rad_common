class UserCustomersController < ApplicationController
  before_action :set_user_customer, only: :destroy

  def new
    @user = User.find(params[:user_id])
    @user_customer = UserCustomer.new
    @user_customer.user = @user
    authorize @user_customer
  end

  def create
    @user = User.find(params[:user_customer][:user_id])
    @user_customer = UserCustomer.new(permitted_params)
    @user_customer.user = @user
    authorize @user_customer

    if @user_customer.save
      redirect_to @user_customer.user, notice: 'Customer was successfully added.'
    else
      render :new
    end
  end

  def destroy
    user = @user_customer.user

    if @user_customer.destroy
      flash[:success] = 'Customer was successfully deleted.'
    else
      flash[:error] = @user_customer.errors.full_messages.join(', ')
    end

    redirect_to user
  end

  private

    def set_user_customer
      @user_customer = UserCustomer.find(params[:id])
      authorize @user_customer
    end

    def permitted_params
      params.require(:user_customer).permit(:customer_id)
    end
end
