class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  before_filter :current_user
   
  private
   
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    if session[:user_id] && session[:user_expiry_time]
      if session[:user_expiry_time] >= 20.minutes.ago.to_s
        session[:user_expiry_time] = Time.current.to_s
      else
        reset_session
        flash[:error] = "Session expired, please login"
        redirect_to signin_path
      end 
    else
      redirect_to signin_path
    end 
  end 

  def reset_session
    session[:user_id] = nil
    session[:user_expiry_time] = nil
  end
end
