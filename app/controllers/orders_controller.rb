class OrdersController < ApplicationController
  before_action :require_user
  def show
    @order = Order.find(params[:id])
  end

  def create
    if !@cart.contents.empty?
      order = current_user.orders.new
      order.create_order(@cart, date_params)
      if order.cats.any? { |cat| cat.orders.reserved?(order) }
        flash[:notice] =
          "One of the cats in your order is already reserved on that date."
        redirect_to cart_path
      else
        order.save
        session[:cart] = {}
        flash[:alert]  = "Order was successfully placed"
        redirect_to "/orders"
      end
    else
      flash[:notice] = "Your cart is empty"
      redirect_to cart_path
    end
  end

  private

  def date_params
    params.require(:order).
      permit("start_date(1i)", "start_date(2i)", "start_date(3i)").
      values.map(&:to_i)
  end
end
