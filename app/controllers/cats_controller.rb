class CatsController < ApplicationController
  def index
    @cats       = Cat.all
    @categories = Category.all
  end

  def show
    @cat = Cat.find(params[:id])
  end

end
