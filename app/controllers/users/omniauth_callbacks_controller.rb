class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    user = User.find_for_facebook_oauth(request.env['omniauth.auth'], current_user)
    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      flash[:notice] = 'Could not authenticate you from Facebook. Invalid email or login.'
      redirect_to root_path
    end
  end

  def twitter
    data = session['devise.omniauth_data'] = User.build_twitter_auth_cookie_hash(request.env['omniauth.auth'])
    user = User.find_for_twitter_oauth(data)
    if user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', :kind => 'Twitter'
      sign_in_and_redirect user, :event => :authentication
    else
      flash[:notice] = 'Authentication error'
      redirect_to root_path
    end
  end

  def vkontakte
    user = User.find_for_vkontakte_oauth request.env["omniauth.auth"]
    if user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Vkontakte"
      sign_in_and_redirect user, :event => :authentication
    else
      flash[:notice] = "Authentication error"
      redirect_to root_path
    end
  end

end