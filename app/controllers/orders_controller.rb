class OrdersController < ApplicationController
  before_action :require_user
  def show
    @order = Order.find(params[:id])
  end

  def create
    if !@cart.contents.empty?
      order = current_user.orders.create
      order.create_order(@cart)
      session[:cart] = {}
      flash[:alert] = "Order was successfully placed"
      redirect_to "/orders"
    else
      flash[:notice] = "Your cart is empty"
      redirect_to cart_path
    end
  end
end
