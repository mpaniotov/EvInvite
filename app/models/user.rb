class User < ActiveRecord::Base
  has_many :events
  has_many :user_providers, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable, :omniauth_providers => [:facebook, :twitter, :vkontakte]
  validates :email, :uniqueness => true

end
