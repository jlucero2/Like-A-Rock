class Comment < ActiveRecord::Base
  attr_accessible :body
  validates :body, :presence => true
  belongs_to :image, :counter_cache => true
  belongs_to :user
end
