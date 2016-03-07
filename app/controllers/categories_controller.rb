class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @category   = Category.find_by(name: params[:name])
  end
end
