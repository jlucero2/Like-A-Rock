class Comment < ActiveRecord::Base
  belongs_to :image
  belongs_to :user
  attr_accessible :body

  validates :body, :presence => true
end
