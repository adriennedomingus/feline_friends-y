class CartsController < ApplicationController
  include CartsHelper
  before_action :find_cat, only: [:create, :destroy]

  def create
    @cart.add_cat(@cat.id)
    session[:cart] = @cart.contents
    double_click_message = "You have already added #{@cat.name} to your cart!"
    added_message = "#{@cat.name} has been added to your cart!"
    flash[:alert] = added_message unless @cart.double_click?(@cat.id)
    flash[:notice] = double_click_message if @cart.double_click?(@cat.id)
    redirect_to cats_path
  end

  def show
    @cats  = @cart.cats
    @order = Order.new
  end

  def destroy
    @cart.remove_cat(@cat.id)
    flash[:alert] = "Successfully removed #{path(@cat)} from cart"
    redirect_to cart_path
  end

  private

  def find_cat
    @cat = Cat.find(params[:cat_id])
  end
end
