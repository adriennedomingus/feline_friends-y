class Admin::CatsController < Admin::BaseController
  before_action :find_cat, only: [:edit, :update, :change_status]
  def new
    @cat = Cat.new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      flash[:alert] = "You have added #{@cat.name} to the site!"
      redirect_to cats_path
    else
      flash[:notice] = "Please enter all information"
      render :new
    end
  end

  def update
    if @cat.update(cat_params)
      flash[:alert] = "You have edited #{@cat.name}!"
      redirect_to cats_path
    else
      flash.now[:notice] = "Please enter all information"
      render :edit
    end
  end

  def change_status
    @cat.change_cat_status(@cat)
    flash[:alert] = "You have changed #{@cat.name}'s status to #{@cat.status}!"
    redirect_to cat_path(@cat)
  end

  private

  def cat_params
    params.require(:cat).
      permit(:name, :price, :description, :age, :image, :category_id, :status)
  end

  def find_cat
    @cat = Cat.find(params[:id])
  end
end
