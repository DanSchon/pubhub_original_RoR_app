class ReviewsController < ApplicationController
  def create
    @pub = Pub.find(params[:pub_id])
    @review = @pub.reviews.new(params.require(:review).permit(:body).merge!(user: current_user))
    if @review.save
      redirect_to @pub
    else
      @reviews = @pub.reviews.reload
      render "pubs/show"
    end
  end
end