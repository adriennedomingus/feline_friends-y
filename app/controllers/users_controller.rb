class UsersController < ApplicationController
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
    render file: "/public/404" unless current_user == User.find(params[:id])
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
