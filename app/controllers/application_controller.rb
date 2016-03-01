class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :create_cart

  def create_cart
    @cart = Cart.new(session[:cart])
  end
end
