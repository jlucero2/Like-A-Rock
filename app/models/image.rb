class Image < ActiveRecord::Base
  attr_accessible :sol, :url

  validates :url,  :presence => true
  validates :sol, :presence => true

  has_many :comments
end
