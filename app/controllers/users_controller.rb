class UsersController < ApplicationController
  before_action :require_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash.now[:notice] = "Please enter a valid username and password"
      render :new
    end
  end

  def show
  end

  def edit
    unless current_user == User.find_by(id: params[:id])
      render file: "/public/404"
    end
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
    params.require(:user).permit(:username, :password, :name)
  end
end
