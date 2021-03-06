class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
      Stripe::Charge.create(
        :amount => 500,
        :currency => "usd",
        :source => params[:stripeToken], # obtained with Stripe.js
        :description => "Charge for #{@user.email}"
      )
      redirect_to sign_in_path
      flash[:success] = "You are registered. Please sign in."
    else
      render :new
      flash[:error] = "Incorrect email or password."
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password)
  end

end