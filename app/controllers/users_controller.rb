class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      AppMailer.send_welcome_email(@user).deliver_now
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