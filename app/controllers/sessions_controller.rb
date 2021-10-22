class SessionsController < ApplicationController

  before_action :logged_in_redirect, only: [:new, :create]
  before_action :logged_in?, only: [:show]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    session = user&.session
    if user && user.authenticate(params[:session][:password])
      streak_count!(session) if session.update(session_params)
      remember!(session)
      flash[:notice] = "Logged in successfully"
      redirect_to(user)
    else
      flash.now[:alert] = "There was something wrong with your login detail"
      render('new')
    end
  end

  def destroy
    log_out! if logged_in?
    redirect_to(root_path)
  end

  private

  def logged_in_redirect
    if logged_in?
      flash[:notice] = "You are already logged in"
      redirect_to(root_path)
    end
  end

  def session_params
    params.require(:session).permit(:updated_at)
  end

end
