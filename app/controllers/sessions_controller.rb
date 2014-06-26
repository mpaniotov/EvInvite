class SessionsController < ApplicationController
  def create
    current_user = User.from_omniauth(auth_hash)
    session[:user_id] = current_user.id
    render :json => auth_hash
    #redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_user_session_path
  end

private
  def auth_hash
    request.env['omniauth.auth']
  end
end