class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:session][:username])
    if @user.nil?
      redirect_to new_user_path
      flash[:notice] = "Please register"
    elsif @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to user_dashboard_path
    else
      flash.now[:notice] = "Please enter valid username and password"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
