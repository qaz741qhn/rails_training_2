class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find(session[:user_id])
    else
      user = User.find_by(id: user_id)
      session = user.session
      if user && session.authenticated?(cookies[:remember_token])
        session[:user_id] = user.id
        @current_user = user
      end
    end
  end

  def logged_in?
    !!current_user
  end

  def remember(session)
    session.remember
    cookies.permanent[:remember_token] = session.remember_token
  end

  def forget(session)
    session.forget
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    current_user = nil
  end
end
