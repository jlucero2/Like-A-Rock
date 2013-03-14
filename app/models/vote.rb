class Vote < ActiveRecord::Base
  #belongs_to :user
  attr_accessible :user #either IP address of guest or ID of user
  validates :image, :presence => true
  belongs_to :image
end
