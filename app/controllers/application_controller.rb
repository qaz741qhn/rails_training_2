class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    if session[:token]
      @current_user ||= User.find_by(session: session[:session_id])
    else
      user = User.find_by(session: session[:session_id])
      if user && user.session.authenticated?(cookies[:token])
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
    if session[:token_digest]
      session = current_user.session
      forget(session)
      current_user = nil
      flash[:notice] = "Logged out"
    else
      flash[:alert] = "You are already logged out"
    end
  end

  def save_to_session(user)
    session = Session.new
    session.user = user
    session.save
  end

end
