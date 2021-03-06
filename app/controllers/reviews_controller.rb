class ReviewsController < ApplicationController
  def create
    cat = Cat.find(params[:cat_id])
    review = cat.reviews.new(review_params)
    if review.save
      current_user.reviews << review
      flash[:alert] = "You added a review of #{cat.name}!"
    else
      flash[:notice] = "Please complete all fields"
    end
    redirect_to cat_path(cat)
  end

  private

  def review_params
    params.require(:review).permit(:score, :comment, :cat_id)
  end
end
