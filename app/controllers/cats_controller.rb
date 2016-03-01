class CatsController < ApplicationController
  def index
    @cats = Cat.all
    @categories = Category.all
  end
end
