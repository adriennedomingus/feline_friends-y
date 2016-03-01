class CartsController < ApplicationController
  include ActionView::Helpers::UrlHelper
  def create
    cat = Cat.find(params[:cat_id])
    @cart.add_cat(cat.id)
    session[:cart] = @cart.contents
    redirect_to cats_path
  end

  def show
    @cats = []
    @cart.contents.each do |cat, _|
      @cats << Cat.find(cat.to_i)
    end
    @cats
  end

  def destroy
    cat = Cat.find(params[:cat_id])
    @cart.remove_cat(params[:cat_id])
    flash[:alert] = "Successfully removed #{path(cat)} from cart"
    redirect_to cart_path
  end

  def path(cat)
    "<a href=\"/cats/#{cat.id}\">#{cat.name}</a>"
  end
end
