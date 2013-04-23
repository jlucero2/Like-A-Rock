class Album < ActiveRecord::Base
  attr_accessible :url, :sol, :num_images, :earthday
  validates :num_images, :presence => true 
  has_many :images
end
