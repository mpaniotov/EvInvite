class UserProvider < ActiveRecord::Base
  belongs_to :user

  def self.find_for_facebook_oauth(auth)
    user = UserProvider.where(:provider => auth.provider, :uid => auth.uid).first
    unless user.nil?
      user.user
    else
      registered_user = User.where(:email => auth.info.email).first
      unless registered_user.nil?
        UserProvider.create!(
                             provider: auth.provider,
                             uid: auth.uid,
                             user_id: registered_user.id
                            )
        registered_user
      else
        user = User.create!(
                            name: auth.info.name,
                            email: auth.info.email,
                            password: Devise.friendly_token[0,20]
                           )
        UserProvider.create!(
                             provider:auth.provider,
                             uid:auth.uid,
                             user_id: user.id
                            )
        user
      end
    end
  end

  def self.find_for_twitter_oauth(auth)
    user = UserProvider.where(:provider => auth.provider, :uid => auth.uid).first
    unless user.nil?
      user.user
    else
      registered_user = User.where(:name => auth.info.name).first
      unless registered_user.nil?
        UserProvider.create!(
                             provider: auth.provider,
                             uid: auth.uid,
                             user_id: registered_user.id
                            )
        registered_user
      else
        user = User.create!(
                            name: auth.extra.raw_info.name,
                            password: Devise.friendly_token[0,20]
                           )

        UserProvider.create!(
                             provider:auth.provider,
                             uid:auth.uid,
                             user_id: user.id
                            )
        user
      end
    end
  end

  def self.find_for_vkontakte_oauth access_token
    user = UserProvider.where(:provider => access_token.provider, :uid => access_token.uid).first
    unless user.nil?
      user.user
    else
      registered_user = User.where(:name => access_token.info.name).first
      unless registered_user.nil?
        UserProvider.create!(
                             provider: access_token.provider,
                             uid: access_token.uid,
                             user_id: registered_user.id
                            )
        registered_user
      else
        user = User.create!(
                            name: access_token.info.name,
                            password: Devise.friendly_token[0,20]
                           )

        UserProvider.create!(
                             provider:access_token.provider,
                             uid:access_token.uid,
                             user_id: user.id
                            )
        user
      end
    end
  end

end
