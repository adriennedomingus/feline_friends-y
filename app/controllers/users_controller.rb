class UsersController < ApplicationController
  before_action :require_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def create
    User.transaction do
      @user = User.create(user_params)
      @user.address = Address.create(address_params)
    end
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash.now[:notice] = "Please enter a valid username and password"
      render :new
    end
  end

  def edit
    unless current_user == User.find(params[:id])
      render file: "/public/404"
    end
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      redirect_to dashboard_path
    else
      flash.now[:notice] = "Please enter a valid attributes"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :name, :address)
  end

  def address_params
    params[:user].require(:address).permit(:country,
                                           :state,
                                           :city,
                                           :street,
                                           :zip)
  end
end
