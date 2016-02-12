class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(full_name: params[:full_name])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id 
      flash[:success] = "You are signed in, enjoy!"
      redirect_to home_path
    else
      flash[:error] = "Incorrect name or password."
      redirect_to sign_in_path
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end