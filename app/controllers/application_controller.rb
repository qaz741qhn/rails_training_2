class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    return nil unless cookies[:token]
    @current_user ||= Session.find_by(token_digest: cookies[:token])&.user
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
  end

  def log_out!
    session = Session.find_by(token_digest: cookies[:token])
    if session
      forget(current_user.session)
      flash[:notice] = "Logged out"
    else
      flash[:alert] = "You are already logged out"
    end
  end

  def save_session(user)
    session = Session.new
    session.user = user
    cookies.permanent[:token] = session.token_digest
    session.save
  end

end
