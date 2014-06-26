class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,  :omniauthable, :omniauth_providers => [:facebook]
  has_many :events


  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      user
    else
      registered_user = User.where( email: auth.info.email ).first
      if registered_user
        registered_user
      else
        user= User.create(name: auth.extra.raw_info.first_name,
                          provider: auth.provider,
                          uid: auth.uid,
                          email: auth.info.email,
                          password: Devise.friendly_token[ 0, 20 ] ).tap {|u|
          logger.info "*" * 25 + "USER INFO " + "*" * 25

          logger.info auth

          logger.info "*" * 50


        }
      end
    end
  end

end
