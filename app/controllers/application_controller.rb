class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :current_user?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def current_user?(user)
    user == current_user
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "ログインしてください"
      redirect_to login_path
    end
  end
end