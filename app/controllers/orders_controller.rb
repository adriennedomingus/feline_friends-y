class OrdersController < ApplicationController
  before_action :require_user
  def show
    @order = Order.find(params[:id])
  end

  def create
    order = current_user.orders.create
    order.update(start_date: Date.new(params[:order]["start_date(1i)"].to_i, params[:order]["start_date(2i)"].to_i, params[:order]["start_date(3i)"].to_i))
    order.update(end_date: order.start_date + 7.days)
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
