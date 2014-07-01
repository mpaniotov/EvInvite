class User < ActiveRecord::Base
  has_many :events
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable, :omniauth_providers => [:facebook, :twitter, :vkontakte]


  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      user
    else
      registered_user = User.where( email: auth.info.email ).first
      if registered_user
        registered_user
      else
        user = User.create(name: auth.extra.raw_info.first_name,
                          provider: auth.provider,
                          uid: auth.uid,
                          email: auth.info.email,
                          password: Devise.friendly_token[ 0, 20 ] )
      end
    end
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth[:provider], :uid => auth[:uid].to_s).first
    unless user
      user = User.create(
          :name => auth[:name],
          :provider => auth[:provider],
          :uid => auth[:uid],
          :password => Devise.friendly_token[0,20]
      )
    end
    user
  end

  def self.build_twitter_auth_cookie_hash data
    {
        :provider => data.provider, :uid => data.uid.to_i,
        :access_token => data.credentials.token, :access_secret => data.credentials.secret,
        :name => data.info.name,
    }
  end

  def self.find_for_vkontakte_oauth access_token
    if user = User.where(:provider => access_token[:provider], :uid => access_token[:uid].to_s).first
      user
    else
      User.create!(:provider => access_token.provider,
                   :name => access_token.info.name,
                   :uid => access_token.uid,
                   :password => Devise.friendly_token[0,20])
    end
  end

end
