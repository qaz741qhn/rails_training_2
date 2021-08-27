class SessionsController < ApplicationController

  before_action :logged_in_redirect, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully"
      redirect_to user
    else
      flash.now[:alert] = "There was something wrong with your login detail"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end

  private

  def logged_in_redirect
    if logged_in?
      flash[:notice] = "You are already logged in"
      redirect_to root_path
    end
  end

end
