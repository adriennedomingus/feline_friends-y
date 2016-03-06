class OrdersController < ApplicationController
  before_action :require_user
  def show
    @order = Order.find(params[:id])
  end

  def create
    if !@cart.contents.empty?
      order = current_user.orders.create
      order.create_order(@cart)
      order.update(start_date: Date.new(params[:order]["start_date(1i)"].to_i, params[:order]["start_date(2i)"].to_i, params[:order]["start_date(3i)"].to_i))
      order.update(end_date: order.start_date + 7.days)
      order.cats.each do |cat|
        if !cat.orders.one? { |cat_order| cat_order.range === order.start_date }
          flash[:notice] = "Sorry #{cat.name} is already reserved on that date."
          order.destroy
          redirect_to cart_path
        else
          session[:cart] = {}
          flash[:alert] = "Order was successfully placed"
          redirect_to "/orders"
        end
      end
    else
      flash[:notice] = "Your cart is empty"
      redirect_to cart_path
    end
  end
end
