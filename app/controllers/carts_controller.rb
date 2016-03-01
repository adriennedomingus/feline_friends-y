class CartsController < ApplicationController
  def create
    cat = Cat.find(params[:cat_id])
    @cart.add_cat(cat.id)
    session[:cart] = @cart.contents
    redirect_to cats_path
  end
end
