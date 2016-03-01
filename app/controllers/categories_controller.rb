class CategoriesController < ApplicationController
  def show
    @category = Category.find_by(name: params[:name])
    @cats = @category.cats
  end
end
