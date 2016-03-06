class CartsController < ApplicationController
  include CartsHelper
  def create
    cat = Cat.find(params[:cat_id])
    @cart.add_cat(cat.id)
    session[:cart] = @cart.contents
    double_click_message = "You have already added #{cat.name} to your cart!"
    added_message = "#{cat.name} has been added to your cart!"
    flash[:alert] = added_message unless @cart.double_click?(cat.id)
    flash[:notice] = double_click_message if @cart.double_click?(cat.id)
    redirect_to cats_path
  end

  def show
    @cats = @cart.add_contents_to_cart(@cart.contents)
    @order = Order.new
  end

  def destroy
    cat = Cat.find(params[:cat_id])
    @cart.remove_cat(params[:cat_id])
    flash[:alert] = "Successfully removed #{path(cat)} from cart"
    redirect_to cart_path
  end
end
