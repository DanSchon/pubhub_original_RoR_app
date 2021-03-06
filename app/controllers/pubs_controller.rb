class PubsController < ApplicationController
  def index
    @pubs = Pub.all
    @pub = Pub.new
  end
  def create
    @pub = Pub.new(params.require(:pub).permit(:title, :url, :content))
    @pub.user = current_user
    if @pub.save
      redirect_to home_path
    else
      flash[:error] = "All fields are required!"
      render :new
    end
  end
  def show
    @pub = Pub.find(params[:id])
    @review = Review.new
  end
  def search
    @results = Pub.search_by_title(params[:search_term])
  end
end