class SessionsController < ApplicationController
  def new
  end
   
  def create
    user = User.authenticate( params[:email], params[:password] )
    if user
      session[:user_id] = user.id
      session[:user_expiry_time] = Time.current.to_s
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end
   
  def destroy
    flash[:error] = "You have signed out"
    session[:user_id] = nil
    session[:user_expiry_time] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
