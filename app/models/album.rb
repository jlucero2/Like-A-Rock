class Album < ActiveRecord::Base
  attr_accessible :url, :timestamp, :sol, :num_images
  validates :sol, :presence => true, :uniqueness => true
  validates :num_images, :presence => true 
  has_many :images
end
