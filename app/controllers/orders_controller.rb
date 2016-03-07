class OrdersController < ApplicationController
  before_action :require_user
  def show
    @order = Order.find(params[:id])
  end

  def create
    if !@cart.contents.empty?
      year, month, day = date_params
      order = current_user.orders.new
      order.create_order(@cart)
      order.assign_attributes(start_date: Date.new(year, month, day))
      order.assign_attributes(end_date: order.start_date + 7.days)
      if order.cats.any? { |cat| cat.orders.reserved? }
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
    year  = params[:order]["start_date(1i)"].to_i
    month = params[:order]["start_date(2i)"].to_i
    day   = params[:order]["start_date(3i)"].to_i
    [year, month, day]
  end
end
