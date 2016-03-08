class OrdersController < ApplicationController
  before_action :require_user
  def show
    @order = Order.find(params[:id])
  end

  # class OrderProcessor
  #   def initialize(current_user, cart, date_params)
  #     @current_user = current_user
  #     @cart = cart
  #     @date_params = date_params
  #   end
  #
  # end

  def create
    if @cart.contains_cats?
      order = current_user.orders.new
      order.create_order(@cart, date_params)
      # process_order = OrderProcessor.new(current_user, @cart, date_params)
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
    params.require(:order).
      permit("start_date(1i)", "start_date(2i)", "start_date(3i)").
      values.map(&:to_i)
  end
end
