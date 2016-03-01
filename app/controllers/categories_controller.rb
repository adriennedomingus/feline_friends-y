class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @category = Category.find_by(name: params[:name])
    @cats = @category.cats
  end
end
