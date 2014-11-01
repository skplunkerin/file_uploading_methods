class UsersController < ApplicationController
  def new
    @user = User.new
  end
   
  def create
    @user = User.new( user_params )
    if @user.save
      # Generate profile for user
      profile = Profile.new( {:user_id => @user.id} )
      profile.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end
   
  private
  def user_params
    params.require( :user ).permit( :email, :first_name, :last_name, :current_password, :password, :password_confirmation )
  end
end
