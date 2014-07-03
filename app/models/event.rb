class Event < ActiveRecord::Base
  require 'carrierwave'
  belongs_to :user
  attr_accessible :address, :latitude, :longitude
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  belongs_to :categorie
  mount_uploader :photo, PhotoUploader
end
