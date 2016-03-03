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
    current_user
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :name)
  end
end
