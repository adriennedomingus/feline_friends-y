class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:session][:username])
    if @user.admin? && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to admin_dashboard_path
    elsif @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to dashboard_path
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
