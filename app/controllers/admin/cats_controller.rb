class Admin::CatsController < Admin::BaseController
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

  private

  def cat_params
    params.require(:cat).
      permit(:name, :price, :description, :age, :image, :category_id)
  end
end
