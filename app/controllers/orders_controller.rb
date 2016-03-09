class OrdersController < ApplicationController
  before_action :require_user
  def show
    @order = Order.find(params[:id])
  end

  def create
    order = current_user.orders.new
    message = OrderProcessor.
              process(order, @cart, start_date_params, end_date_params)
    if message
      flash[:notice] = message
      redirect_to cart_path
    else
      order.save
      session[:cart] = {}
      flash[:alert]  = "Order was successfully placed"
      redirect_to "/orders"
    end
  end

  private

  def start_date_params
    params.require(:order).permit(:start_date)
  end

  def end_date_params
    params.require(:order).permit(:end_date)
  end
end
