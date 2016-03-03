class OrdersController < ApplicationController
  before_action :require_user

  def index
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    order = current_user.orders.create
    order.create_order(@cart)
    flash[:alert] = "Order was successfully placed"
    redirect_to "/orders"
  end
end
