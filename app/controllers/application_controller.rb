class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :current_admin?
  before_action :create_cart

  def create_cart
    @cart = Cart.new(session[:cart])
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def require_user
    unless current_user
      flash[:alert] = "Please log in"
      redirect_to login_path
    end
  end
end
