class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :login_streak_display, :daily_logins_display

  def current_user
    return @current_user if defined? @current_user
    return @current_user = nil unless cookies[:token]
    session = Session.find_by(token_digest: cookies[:token])
    return @current_user = nil if session.blank? || session.expires_at < Time.current
    @current_user = session.user
  end

  def logged_in?
    !!current_user
  end

  def remember!(session)
    session.remember!
    cookies[:token] = { value: session.token_digest, expires: 3.days.from_now }
  end

  def forget!(session)
    session.forget!
  end

  def log_out!
    session = Session.find_by(token_digest: cookies[:token])
    if session
      forget!(current_user.session)
      flash[:notice] = "Logged out"
    else
      flash[:alert] = "You are already logged out"
    end
  end

  def save_session(user)
    session = Session.new
    session.user = user
    session.save
  end

  def login_streak_display(user)
    user.login_streak_count!
  end

  def daily_logins_display(user)
    user.daily_login_count!
  end

end
