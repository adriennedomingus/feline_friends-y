class CartsController < ApplicationController
  include ActionView::Helpers::UrlHelper
  include CartsHelper
  def create
    cat = Cat.find(params[:cat_id])
    @cart.add_cat(cat.id)
    session[:cart] = @cart.contents
    redirect_to cats_path
  end

  def show
    @cats = @cart.add_contents_to_cart(@cart.contents)
  end

  def destroy
    cat = Cat.find(params[:cat_id])
    @cart.remove_cat(params[:cat_id])
    flash[:alert] = "Successfully removed #{path(cat)} from cart"
    redirect_to cart_path
  end
end
