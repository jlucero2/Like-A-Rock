class Album < ActiveRecord::Base
  attr_accessible :url, :timestamp, :sol, :num_images, :earthday
#  validates :earthday, :sol, :presence => true, :uniqueness => true
  validates :num_images, :presence => true 
  has_many :images
end
