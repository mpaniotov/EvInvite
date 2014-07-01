class Event < ActiveRecord::Base
  require 'carrierwave'
  belongs_to :user
  belongs_to :categorie
  mount_uploader :photo, PhotoUploader
end
