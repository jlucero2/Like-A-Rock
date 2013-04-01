class Response < ActiveRecord::Base
  belongs_to :image, :counter_cache => true
  belongs_to :admin
  attr_accessible :body

  validates :body, :presence => true
end
