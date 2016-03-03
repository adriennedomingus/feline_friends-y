class OrdersController < ApplicationController
  before_action :require_user

  def index
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    order = current_user.orders.create
    if !@cart.contents.empty?
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
