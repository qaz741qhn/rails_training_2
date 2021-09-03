class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    user = User.find_by(id: user_id)
    if (user.session.token_digest = session[:token])
      @current_user ||= User.find_by(session.token_digest: session[:token])
    else
      user = User.find_by(id: user_id)
      session = user.session
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
    session.delete(:token)
    current_user = nil
  end
end
