class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = UserProvider.find_for_facebook_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_path
    end
  end

  def twitter
    data = request.env['omniauth.auth']
    session['devise.omniauth_data'] = data
    user = UserProvider.find_for_twitter_oauth(data)
    if user.email.empty?
      flash.now[:error] = 'Please specify your email address'
      @user = user
      render :append_email
    elsif user.persisted?
      sign_in_and_redirect user, :event => :authentication
    else
      session['devise.omniauth_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_path
    end
  end

  def vkontakte
    data = request.env['omniauth.auth']
    session['devise.omniauth_data'] = data
    user = UserProvider.find_for_vkontakte_oauth data
    if user.email.empty?
      flash.now[:error] = 'Please specify your email address'
      @user = user
      render :append_email
    elsif user.persisted?
      sign_in_and_redirect user, :event => :authentication
    else
      session['devise.omniauth_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_path
    end
  end

end