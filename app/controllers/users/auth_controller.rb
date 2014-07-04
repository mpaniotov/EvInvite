class Users::AuthController < ApplicationController

  def create
    data = session['devise.omniauth_data']
    data[:email] = params[:user][:email]
    user_id = UserProvider.where("provider = ? AND uid = ?", data['provider'], data['uid']).pluck(:user_id).first
    @user = User.where(:id => user_id).first
    @user.email = data[:email]
    if @user.valid? and @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
    else
      #@user.errors.inspect
      flash.now[:error] = 'This email has been already taken'
      render 'users/omniauth_callbacks/append_email'
    end
  end

end