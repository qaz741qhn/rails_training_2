class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    if session[:token]
      @current_user ||= User.find_by(email: session[:email])
    else
      user = User.find_by(email: session[:email])
      if user && session.authenticated?(cookies[:token])
        session[:token] = user.session.token_digest
        @current_user = user
      end
    end
  end

  def logged_in?
    !!current_user
  end

  def remember(session)
    session.remember
    cookies.permanent[:token] = session.token_digest
  end

  def forget(session)
    session.forget
    cookies.delete(:token)
  end

  def log_out
    forget(current_user)
    current_user = nil
  end

  def save_to_session(user)
    session = Session.new
    session.user = user
  end

end
