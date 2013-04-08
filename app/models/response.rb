class Response < ActiveRecord::Base
  belongs_to :image, :counter_cache => true
  belongs_to :admin
  attr_accessible :body, :url

  validates :body, :presence => true
end
